# Tranlated sentence generation
fairseq-generate \
    data-bin/wiki_src_tgt_bpe5000/ \
    --source-lang src --target-lang tgt \
    --path checkpoints/checkpoint_best.pt \
    --beam 5 --lenpen 1.2 \
    --gen-subset test \
    --remove-bpe=sentencepiece \ > output.txt