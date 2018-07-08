function [fc]=ocr(filename)
%clc, close all, clear all
pkg load image;
%{
global rimalp;
rimalp = 1;
is_pow = 0;
can_be_pow = 0;
last_bottom = -1;
last_top = 99999;
num_of_open_parens = 0;
in_sqrt = 0;
start_of_sum_or_product_or_integral = 0;
sum_or_product_or_integral_body = 0;
need_right_paren = 0;
sum_or_product_or_integral_paren_num = 0;
check_integral_range = 0;
in_integral = 0;
close_integral = 0;
word=zeros(1, 50);
index = 1;
%}

%editted code
image=filename;
re = loadBWImage(image);
%imshow(re);
% Load templates
%load templates
%global templates
% Compute the number of letters in template file
%symbols_num=size(templates,2)
i=1;
while (not(isempty(re)))
    [col, re] = column(re);
    col=imresize(col,[15 15], 'bilinear');
    fc(i,:) = reshape(col,1, 225);
    i++;
    %imshow(fc);
    %[~, col_clumps] = bwlabel(col);
    %[rows, ~] =find(col);
   % pos = size(col, 1) - max(rows);
   % num_of_row = 0;
   
 %  while (not(isempty(fc)))
       % num_of_row = num_of_row + 1;
      %  [fl, ~, fc]=lines(fc);
        % This if is needed in order not to allow a base be from
        % a previous column and the exponent from the next -
        % in which another lines can be found below - see TEST_16
        %if (not(isempty(fc)))
         %   can_be_pow = 0;
        %end
        % Label and count connected components
        %[L Ne] = bwlabel(fc);
        %imshow(L);
        %for n=1:Ne
      %      [img_r] = nth_letter_in_clump_matrix(fc,1);
		 %end;
  %  end;
    end;
  %{ 
   if (letter == '(')
				num_of_open_parens  = num_of_open_parens + 1;
			end
			if (letter == ')')
				num_of_open_parens  = num_of_open_parens - 1;
			end

            if all (in_integral & letter == 'd')
                close_integral = 1;
            end
            bottom = pos + size(L, 1) - max(r);
            top = bottom + max(r) - min(r);
            if (letter == '-')
                dif = (max(c) - min(c)) / 5;
                bottom = bottom - dif;
                top = top + dif;
            end
            
            if all(is_pow & ~strcmp(letter, '/') & (bottom + (max(r) - min(r) + 1) / 2 <= last_bottom...
                | (letter == '(' & bottom + (max(r) - min(r) + 1) / 4 <= last_bottom)))
                is_pow = 0;
                word(index) = ')';
                index = index + 1;
                num_of_open_parens = num_of_open_parens - 1;
            end
            if all((2 * last_top - last_bottom >= bottom) & can_be_pow &...
                    ((isLetterOrNum(letter) & (last_bottom + (last_top - last_bottom) * 0.45 <= bottom))...
                    | (~isLetterOrNum(letter) & (letter ~= '''')  & (last_bottom + (last_top - last_bottom) <= bottom))...
                    | (letter == '(' & (last_bottom + (last_top - last_bottom) * 0.4  <= bottom))))
                is_pow = 1;
                word(index) = '^';
                index = index + 1;
                word(index) = '(';
                index = index + 1;
                last_bottom = bottom;
                last_top = top;
                num_of_open_parens = num_of_open_parens + 1;
            elseif all (~isSign(letter) & (isLetterOrNum(letter)  |  (letter == ')')))
                can_be_pow = 1;
                last_bottom = bottom;
                last_top = top;
            else
                can_be_pow = 0;
            end
            if (check_integral_range)
                check_integral_range = 0;
                word(index) = '(';
                index = index + 1;
                sum_or_product_or_integral_paren_num = num_of_open_parens;
                num_of_open_parens = num_of_open_parens + 1;
                need_right_paren = 1;
            end
            if (sum_or_product_or_integral_body)
                sum_or_product_or_integral_body = 0;
                %                 if (letter ~= '(')
                word(index) = '(';
                index = index + 1;
                sum_or_product_or_integral_paren_num = num_of_open_parens;
                num_of_open_parens = num_of_open_parens + 1;
                need_right_paren = 1;
                %                 else
                %                     need_right_paren = 0;
                %                 end
            end
            if ((close_integral && ~isLetterOrNum(letter) && ~is_pow) || (need_right_paren ...
                    && (strcmp(letter, '+') || strcmp(letter, '-')) && num_of_row == 1 && Ne == 1 ...
                    && sum_or_product_or_integral_paren_num == num_of_open_parens - 1 && ~is_pow))
                close_integral = 0;
                word(index) = ')';
                index = index + 1;
                word(index) = ':';
                index = index + 1;
                word(index) = char(10);
                index = index + 1;
                num_of_open_parens = num_of_open_parens - 1;
                need_right_paren = 0;
            end
            if (start_of_sum_or_product_or_integral && isempty(fc) && n == Ne)
                start_of_sum_or_product_or_integral = 0;
                sum_or_product_or_integral_body = 1;
            end

            if (is_pow)
                can_be_pow = 0;
            end
            
            %             if (n < Ne)
            %                 [~ , ~, next_letter] = nth_letter_in_clump_matrix(L, n  + 1, symbols_num);
            %                 if (all(~isLetterOrNum(next_letter)  & (next_letter ~= '(')))
            %                     if (n + 1 < Ne)
            %                     	[~ , ~, next_next_letter] = nth_letter_in_clump_matrix(L, n  + 2, symbols_num);
            %                             if (all(~isLetterOrNum(next_next_letter)  & (next_next_letter ~= '(')))
            %                                 can_be_pow = 0; % the previous letter can't be a base of a pow
            %                             end
            %                     else
            %                         can_be_pow = 0;
            %                     end
            %                 end
            %             end
            
            %            if all((letter == '-') & (Ne == 1))
            %                letter = '/';
            %            end
            
            %            if (isLetterOrNum(letter))
            %                last_height = height;
            %            end
            % Letter concatenation
            [~, b] = size(letter);
            for k = 1 :b
                word(index)=letter(k);
                index = index + 1;
            end
            if (strcmp(letter, ' sqrt('))
                [sqr_matrix, num] = bwlabel(bound_rect);
                [~, ~, l, ~] = nth_letter_in_clump_matrix(sqr_matrix, 1, symbols_num);
                in_sqrt = num;
                if (~strcmp(l, ' sqrt('))
                    in_sqrt = in_sqrt - 1;
                end
            end
            if (strcmp(letter, ' sum') || strcmp(letter, ' product') || (strcmp(letter, ' integrate') && not(isempty(fc))))
                start_of_sum_or_product_or_integral = 1;
            end
            if (strcmp(letter, ' integrate'))
                in_integral = 1;
                if (~start_of_sum_or_product_or_integral)
                    check_integral_range = 1;
                end
            end
            if (in_sqrt == 1)
                word(index)=')';
                index = index + 1;
            end
            in_sqrt = in_sqrt - 1;
        end
        word(index)=':';
        index = index + 1;
        % this if is used in order not to create pow in which
        % the base is the last line for some column and the
        % exponent is taken from the next column - see TEST_12
        if (isempty(fc) && col_clumps > 2)
            can_be_pow = 0;
        end
    end
    max_index = find(word > 0, 1, 'last' );
    word = word(1 : max_index);
    fprintf(fid,'%s\n', word);%Write 'word' in text file (upper)
    % Clear 'word' variable
    word=[ ];
    index = 1;
end
while (num_of_open_parens > 0)
    num_of_open_parens = num_of_open_parens - 1;
    fprintf(fid,'%s\n','):');
end
%fseek(fid, 0, 0);
fclose(fid);
%Open 'text.txt' file
%winopen(strcat(image, '.txt'))
clear all
end

function val = isLetterOrNum(letter)
if (size(letter) == 1)
    if all( ( (letter >= '0') & (letter <= '9') ) | ( (letter >= 'A') & (letter <= 'Z') ) | ( (letter >= 'a') & (letter <= 'z') ))
        val = 1;
    else
        val = 0;
    end
else
    sum = 0;
    s = size(letter, 2);
    for i=1:s
        if (isLetterOrNum(letter(i)))
            sum = sum + 1;
        end
    end
    val = s == sum;
end
end

function val = isSign(letter)
val = all((strcmp(letter, 'sum')) | (strcmp(letter, 'integrate')) | ...
    (strcmp(letter, 'sqrt')) | (strcmp(letter, 'product')) | (strcmp(letter, 'arrow')));
end

%}






function img = loadBWImage(image)
% Read image
img=imread(image);
% Convert to gray scale
if size(img,3)==3 %RGB image
    img=rgb2gray(img);
end
img=imresize(img,[330 500]);

%(img(270:end,1:10))
[i,z]=min(mean(img(260:(end-30),:)'));
z=z+260-4;




img=img(235:z,150:370);
%img=img(70:190,130:360);

%imshow(img);
%hold on;
%title("check");
% Convert to BW
threshold=graythresh(img);
img =~im2bw(img,threshold-0.05);
[Le no_o]=bwlabel(img);
x=0;
%{
while(no_o~=12 && x<=8)
x++;
[Le no_o]=bwlabel(img);
img=img(1:(size(img,1)-1),:);
end;
%}
x=0;
while(no_o~=12 && x<=8)
x++;
[Le no_o]=bwlabel(img);
img=img(:,1:(size(img,2)-1));
end;


% Remove all object containing less than 9 pixels
img = bwareaopen(img,9);
img = crop(img);
end
function img_out=crop(img_in)
[r c]=find(img_in);
img_out=img_in(min(r):max(r),min(c):max(c));
end
%{
function [img_r] = nth_letter_in_clump_matrix(L, n)
[r,c] = find(L==n);
n1=L(min(r):max(r),min(c):max(c));
n2 = (n1 == n);
   % figure();
    %imshow(n2);
% Resize letter (same size of template)
img_r=imresize(n2,[20 20], 'bilinear');
imshow(img_r);
    %rimalp:
    % if rimalp<1
   
    %     rimalp=rimalp+1;
    % end
    % Call fcn to convert image to text
end
%}
end