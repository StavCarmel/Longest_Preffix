function [single_suffix_array] = build_single_suffix_array(seq, alphabet)
%  alphabet: nucleotides/ amino acids/ codons
seq_l = length(seq);


if (strcmp(alphabet,'codons'))
    if rem(length(seq),3)~=0
       error(['the sequence''s length does not divide by 3']);
    end
    jump = 3;
    suffix = cell(seq_l/3,1);
    positions = zeros(seq_l/3, 1);
    alphabet_seq=seq;
    seq_l=length(seq)/3;
    seq_length=length(seq);
elseif (strcmp(alphabet,'amino acids'))
    if rem(length(seq),3)~=0
       error(['the sequence''s length does not divide by 3']);
    end
    jump = 1;
    suffix = cell(seq_l/3,1);
    positions = zeros(seq_l/3, 1);
    alphabet_seq=nt2aa(seq);
    seq_l=length(seq)/3;
    seq_length=seq_l;
else
    jump = 1;
    suffix = cell(seq_l,1);
    positions = zeros(seq_l, 1);
    alphabet_seq=seq;
    seq_length=seq_l;
end

count = 0;
for i = 1:jump:seq_length
    count = count+1;
    suffix{count,1} = upper(alphabet_seq(i:end));
    if (strcmp(alphabet,'codons'))
        positions(count) = (i+2)/3;
    else
        positions(count) = i;
    end
end

% sorting alpahbetically
[sorted_suffix, sorted_pos] = sort(suffix);
positions = positions(sorted_pos);

single_suffix_array=cell(seq_l,2);

single_suffix_array(:,1)=strcat(sorted_suffix,'$');
single_suffix_array(:,2)=num2cell(positions(:,1));

    
end