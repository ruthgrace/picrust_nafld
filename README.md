# workflow for running picrust on nafld data set

## turn overlapped 16S rRNA gene seqs from fastq to fasta

```
perl -ne 'y/@/>/;print($_.<>)&&<>&&<>' ../reads/overlap_filtered/overlap_filtered.fastq > ./overlap_filtered.fasta
```

## pick closed reference otus

Using this tutorial: http://picrust.github.io/picrust/tutorials/otu_picking.html#otu-picking-tutorial

```
echo "pick_otus:enable_rev_strand_match True"  >> $PWD/otu_picking_params_97.txt
echo "pick_otus:similarity 0.97" >> $PWD/otu_picking_params_97.txt
pick_closed_reference_otus.py -i $PWD/overlap_filtered.fasta -o $PWD/ucrC97/ -p $PWD/otu_picking_params_97.txt -r $PWD/gg_13_5_otus/rep_set/97_otus.fasta -t $PWD/gg_13_5_otus/taxonomy/97_otu_taxonomy.txt
```

