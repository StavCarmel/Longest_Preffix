function pf = longest_pf(seq,genome)

seq=upper(seq);
[sa,found,index] = binary_search(seq,genome);

% if the binary search didn't find any matching string:
if found==0
[~, idx] = sort({sa{index,1}, seq});
    seqbigger = idx(1) < idx(2); %check which one of the strings is bigger, if the wanted seq id bigger than check the index and index+1; if not check index and index-1; check if index is 1 or length(sa) then don't take -/+1 
    if seqbigger 
        check1=index;
        check2=index+1;
        if check1==length(sa) %if the left checked index is the last index in the suffix array then it is impossible to check the next index (thre is no next suffix)
            index=length(sa);
            match=0; %count the matching chr while the lengthes are fine and doesn't make 'index exceeds boundaries' error
            for chr=1:length(seq)
                if chr>length(sa{index}) %making sure the lengthes are fine
                    break
                end
                if strcmp(seq(chr),sa{index}(chr))
                   match=chr;
                else
                    break
                end
            end
            if match>0 % if match >0 it means there were a match for a certain amount of chr from seq
                found=true(1); % hange found to true for later use
            end
        else
            max_mach1=0; %check for a substring in the suffix for index1 and index2
            max_mach2=0;
            for chr=1:length(seq)
                if chr>length(sa{check1})
                    break
                end
                if strcmp(seq(chr),sa{check1}(chr))
                   max_mach1=chr;
                else
                    break
                end
            end
            for chr=1:length(seq)
                if chr>length(sa{check2})
                    break
                end
                if strcmp(seq(chr),sa{check2}(chr))
                   max_mach2=chr;
                else
                    break
                end
            end
                [iszero,max_mach]=max([max_mach1,max_mach2]); %finding the max match out of check1 and check2 indices
                if iszero~=0 % max_match indicates which index check got the maximal value- it means it got the maximal match, iszero is tha max value, if it is zero than it means that there were no matching chr for index1 and index2
                    found=true(1);
                    if max_mach==1
                        index=check1;
                    elseif max_mach==2
                        index=check2;
                    end
                end
        end
    else
        %the same as before, but the check indices are different, according
        %to if the sequnce is smaller than the suffix in the index binar search showed.
        check1=index-1;
        check2=index;
        if check2==1 %if the right checked index is the first index in the suffix array then it is impossible to check the index before (there is no 0 position in the suffix array)
            index=1;
            match=0;
            for chr=1:length(seq)
                if chr>length(sa{index})
                    break
                end
                if strcmp(seq(chr),sa{index}(chr))
                   match=chr;
                else
                    break
                end
            end
            if match>0
                found=true(1);
            end
        else
            max_mach1=0;
            max_mach2=0;
            for chr=1:length(seq)
                if chr>length(sa{check1})
                    break
                end
                if strcmp(seq(chr),sa{check1}(chr))
                   max_mach1=chr;
                else
                    break
                end
            end
            for chr=1:length(seq)
                if chr>length(sa{check2})
                    break
                end
                if strcmp(seq(chr),sa{check2}(chr))
                   max_mach2=chr;
                else
                    break
                end
            end
            [iszero,max_mach]=max([max_mach1,max_mach2]);
            if iszero~=0
                found=true(1);
                if max_mach==1
                    index=check1;
                elseif max_mach==2
                    index=check2;
                end
            end
        end
    end
end

if found==1
    preffix=sa{index};
    match=0;
    for chr=1:length(seq)
        if chr>length(sa{index})
            break
        end
        if strcmp(seq(chr),sa{index}(chr))
           match=chr;
        else
            break
        end
    end
    pf=preffix(1:match);
else
    pf={};
    disp('The sequence can''t be found in the genome')
end
end



