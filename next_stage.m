function [R_new,L_new,seqbigger]=next_stage(R,L,Mid,seq,suffix)

[~, idx] = sort({suffix, seq});
seqbigger = idx(1) < idx(2); % the sequence is bigger than the suffix
if seqbigger==1
 L_new = Mid;
 R_new= R;
else
  R_new = Mid;
  L_new=L;
end

end