# workflow for running picrust on nafld data set

## turn overlapped 16S rRNA gene seqs from fastq to fasta

```
perl -ne 'y/@/>/;print($_.<>)&&<>&&<>' ../reads/overlap_filtered/overlap_filtered.fastq > ./overlap_filtered.fasta
```

## convert fasta file to have sample_seqid identifiers

```
nohup perl convert_sample_seqid.pl /Volumes/longlunch/seq/LRGC/AF9KK_May1_2015/source_files_Bariatric/bowtie2/combined_rekeyed_tabbed.fa ./combined_rekeyed_tabbed_sample_seqid.fa > convert_sample_seqid_nohup.out 2>&1&
```

## pick closed reference otus and generate metagenome predictions

Tutorial used: http://picrust.github.io/picrust/tutorials/otu_picking.html#otu-picking-tutorial

Download and unzip the greengenes gg_13_5_otus.tar.gz reference from http://greengenes.secondgenome.com/downloads/database/13_5 into your current directory

```
echo "pick_otus:enable_rev_strand_match True"  >> $PWD/otu_picking_params_97.txt
echo "pick_otus:similarity 0.97" >> $PWD/otu_picking_params_97.txt
```

open up the macqiime command line environment:

```
macqiime
```

Run within macqiime:

```
nohup pick_closed_reference_otus.py -i $PWD/combined_rekeyed_tabbed_sample_seqid.fa -o $PWD/ucrC97/ -p $PWD/otu_picking_params_97.txt -r $PWD/gg_13_5_otus/rep_set/97_otus.fasta -t $PWD/gg_13_5_otus/taxonomy/97_otu_taxonomy.txt > pick_closed_reference_otus_nohup.out 2>&1&
```

The output for this was normalized by copy number, and the metagenome predictions were made. I was not able to get it working on my machine, as I do not have permissions on the home drive, but Robin installed and ran everything on a Google Cloud Platform instance. Output files are in a picrust_results folder, in a file called `metagenome_predictions.biom`.

## Analyze picrust results

Convert to tab separated .txt file inside macqiime:

```
biom convert -i metagenome_predictions.biom -o metagenome_predictions.txt -b
```


