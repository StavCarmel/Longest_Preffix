function [sa, found, index] = binary_search(seq, genome)

% uses the function 'next_step' in order to define the new R and L for the next iteration
sa=build_sa(genome,1);
seq=upper(seq);
%initiation
L = 1;
R = length(sa);
index=[];
found=false(1);

checking_rows=length(sa); %amount of rows in the checking area
while checking_rows>1 %while the checking area is bigger than 1- continue checking
    Mid = round((L+R)/2); 
    index=Mid;
    %checking the suffix in the middle point
    if length(sa{Mid})>=length(seq)
        if strcmp(sa{Mid}(1:length(seq)),seq)
            found=true(1);
            index=Mid;
            break
        else
            [R_new,L_new,seqbigger]=next_stage(R,L,Mid,seq,sa{Mid,1});
            if seqbigger
                checking_rows=R-Mid;
            else
                checking_rows=Mid-L;
            end
            R=R_new;
            L=L_new;
        end
    else
        [R_new,L_new,seqbigger]=next_stage(R,L,Mid,seq,sa{Mid,1});
        if seqbigger
            checking_rows=R-Mid;
        else
            checking_rows=Mid-L;
        end
        R=R_new;
        L=L_new;
    end
end

% if didn't find check the 2 suffix remaining
if found==0
    if length(sa{L})>=length(seq) %only of it is longer or at the same length as seq, otherwise it w'ont be equal for sure
        if strcmp(sa{L}(1:length(seq)),seq)
            found=true(1);
            index=L;
        else
            if seqbigger % if still didn't find, update the index according to the last check, if the seq is bigger than the suffix it checked the R position in sa, if it is smaller it checked the L position
                index=R;
            else
                index=L;
            end
        end
    end
    if  length(sa{R})>=length(seq)
        if strcmp(sa{R}(1:length(seq)),seq)
            found=true(1);
            index=R;
        else
            if seqbigger
                index=R;
            else
                index=L;
            end
        end
    end
end