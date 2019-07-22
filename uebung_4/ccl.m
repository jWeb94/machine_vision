function [ labels hist ] = ccl( I, theta, minpixel )
% CCL implements the connected components labeling algorithm
%   [labels hist] = CCL ( I, theta, minpixel )
%   I: the input image that sould be segmented. The image can be given as
%      greyvalue image or color image in any color space
%   theta: the threshold for the ccl algorithm, i.e. the maximal
%          distance in colorspace up to which neighboring pixels are put
%          into the same cluster
%   minpixel: the minimal number of pixels that a segment should have.
%             Smaller clusters are suppressed
%   labels: index image showing to which cluster a pixel belongs to. Index
%           0 means that a pixel belongs to a cluster which is smaller than
%           minpixel
%   hist: a statistics on the cluster sizes. length(hist) is the number of
%         clusters, hist(k) the size of the k-th cluster
[rows cols cdepth] = size (I);
Id = double(I);

% Berechne den Aehnlichkeitmassstab (Euklidischer Abstand) und schreibe
% 1=aehnlich und 0=unaehnlich fuer die benachbarten Pixel in eine Matrix,
% deren Eintraege die Aehnlichkeit jedem Pixel des uebergebenen Bildes
% beinhalten
Cleft = [ zeros(rows,1) sum((Id(:,2:cols,:)-Id(:,1:cols-1,:)).^2,3)<theta*theta ]; % Cleft(v,u) = 1, wenn Id(v,u) und Id(v,u-1) aehnlich
Cup = [ zeros(1,cols); sum((Id(2:rows,:,:)-Id(1:rows-1,:,:)).^2,3)<theta*theta ]; % Cup(v,u) = 1, wenn Id(v,u) und Id(v-1,u) aehnlich
imagesc(Cup);

k = 1;                                      % Label-Inertialwert
labels = uint32(zeros (rows, cols));        % Initialisiere Ergebnismatrix
hist = [];                                  % Initialisiere Histogramm
labelmap = [];                              % ?
% Iteriere ueber alle Pixel des Bildes
for v=1:rows
    for u=1:cols
        if (Cup(v,u))                       % Aehnlichkeit zum oberen Pixel 
                                
            lup = labelmap(labels(v-1,u));  
            if (Cleft(v,u))                 % Aehnlichkeit zum linken Pixel
                lleft = labelmap(labels(v,u-1));   
                if (lup==lleft)                     % 4. Fall
                    hist(lleft) = hist(lleft)+1;
                    labels(v,u) = lleft;            % Weise das Label der beiden benachbarten Pixel zu
                
                else                                % 5. Fall
                    % merger 
                        % Suche das kleinere der Label der beiden
                        % Nachbarpixel
                    lmin = min (lleft, lup);
                    lmax = max (lleft, lup);
                        % Zaehle die Pixel des kleineren Pixels zu denen
                        % des groesseren hinzu
                    hist (lmin) = hist(lmin)+hist(lmax)+1;
                    hist (lmax) = 0;
                        % Weise das kleinere Label den Pixeln des jeweils
                        % anderen Segments und dem aktuellen Pixel zu
                    labelmap (labelmap==lmax) = lmin;
                    labels(v,u) = lmin;
                end
            else                                    % 2. Fall 
                hist(lup) = hist(lup)+1;
                labels(v,u) = lup;
            end
        else                                        % KEINE Aehnlichkeit zum oberen Pixel
            
            if (Cleft(v,u))                         % 1. Fall
                lleft = labelmap(labels(v,u-1));
                hist(lleft) = hist(lleft)+1;
                labels(v,u) = lleft;
            else                                    % 3. Fall
                k = k+1;
                hist(k) = 1;
                labels (v,u) = k;
                labelmap (k) = k;
            end
        end
    end
end

[ hist_sort permut ] = sort (hist, 'descend'); % hist absteigend sortiert
ipermut (permut) = 1:length(permut);
hist = hist_sort;
labels = ipermut(labelmap(labels));
hist (hist<minpixel) = [];          % Loesche alle Labels IM HISTOGRAMM, die aufgrund zu geringer Anzahl an Pixeln (definiert durch minpixel-Parameter) IN DER HISTOGRAMMSTATISTIK weg fallen sollen
labels (labels>length(hist)) = 0;   % Loesche alle Labels, die aufgrund zu geringer Anzahl zugehoeriger Pixel weg gefallen sind
