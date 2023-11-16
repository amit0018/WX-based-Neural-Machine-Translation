#Data Preprocessing
SRC=source_language # Input Source language
TGT=target_language # Input Target Language
BPESIZE=5000
TRAIN_MINLEN=1  # remove sentences with <1 BPE token
TRAIN_MAXLEN=250 # remove sentences with >250 BPE tokens

ROOT=$(dirname "$0")
SCRIPTS=$ROOT/scripts
DATA=$ROOT/data
TMP=$DATA/wiki_${SRC}_${TGT}_bpe${BPESIZE}
DATABIN=$ROOT/data-bin/wiki_${SRC}_${TGT}_bpe${BPESIZE}
mkdir -p $TMP $DATABIN


SRC_TOKENIZER="cat"
TGT_TOKENIZER="cat"  # learn target-side BPE over untokenized (raw) text
SPM_TRAIN=$SCRIPTS/spm_train.py
SPM_ENCODE=$SCRIPTS/spm_encode.py

$SRC_TOKENIZER /path_of_source training data > $TMP/train.$SRC  # path of source training data
$TGT_TOKENIZER /path_of_target training data > $TMP/train.$TGT   # path of target training data

$SRC_TOKENIZER /path_of_source dev data > $TMP/valid.$SRC    # path of source dev data
$TGT_TOKENIZER /path_of_target dev data > $TMP/valid.$TGT     # path of target dev data

$SRC_TOKENIZER /path_of_source test data > $TMP/test.$SRC    # path of source test data
$TGT_TOKENIZER /path_of_source test data > $TMP/test.$TGT     # path of source test data

# learn BPE with sentencepiece
python3 $SPM_TRAIN \
  --input=$TMP/train.$SRC,$TMP/train.$TGT \
  --model_prefix=$DATABIN/sentencepiece.bpe \
  --vocab_size=$BPESIZE \
  --character_coverage=1.0 \
--model_type=bpe

# encode train/valid/test
python3 $SPM_ENCODE \
  --model $DATABIN/sentencepiece.bpe.model \
  --output_format=piece \
  --inputs $TMP/train.$SRC $TMP/train.$TGT \
  --outputs $TMP/train.bpe.$SRC $TMP/train.bpe.$TGT \
  --min-len $TRAIN_MINLEN --max-len $TRAIN_MAXLEN
for SPLIT in "valid" "test"; do \
  python3 $SPM_ENCODE \
    --model $DATABIN/sentencepiece.bpe.model \
    --output_format=piece \
    --inputs $TMP/$SPLIT.$SRC $TMP/$SPLIT.$TGT \
    --outputs $TMP/$SPLIT.bpe.$SRC $TMP/$SPLIT.bpe.$TGT
done

# binarize data
fairseq-preprocess \
  --source-lang $SRC --target-lang $TGT \
  --trainpref $TMP/train.bpe --validpref $TMP/valid.bpe --testpref $TMP/test.bpe \
  --destdir $DATABIN \
  --joined-dictionary \
--workers 4

