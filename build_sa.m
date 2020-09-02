function sa = build_sa(genome,alphabet)

%   uses the 'build_single_suffix_array' function;
%   cell genome contains genes sequences
%   string alphabet is the alphabet type of the output- suffix array
%   nucleotides/ amino acids/ codons
%   output sa is a cell, 1st column is the suffix, 2nt column is the gene of
%   the suffix, the 3rd column is the position in the sequence.

if iscell(genome)
    am_g = length(genome);
    sa = cell(am_g, 1);
    for i = 1:am_g
        l_cur_gene = length(genome{i});
        cur_gene = repmat({i}, l_cur_gene, 1); % create a vector of the genes ID in the length of the gene
        sa{i} = [build_single_suffix_array(genome{i},alphabet), cur_gene];

    end

    sa = cat(1, sa{:}); % get all the genes' array together in the same cell
    [~, idx] = sort(sa(:, 1));
    sa = sa(idx, :);

else
    sa = build_single_suffix_array(genome, alphabet);
end

end
