# WX-based-Neural-Machine-Translation
This repository contains the implementation of NMT described in Paper: "Machine Translation by Projecting Text into the Same Phonetic- Orthographic Space Using a Common Encoding"

Dependencies can be installed via pip:

$ pip install fairseq sacrebleu sentencepiece


For proposed approach:

1. Run utftowx.py  /* Transliterate the text to WX-notation.*/

2. Run preprocess.sh  /* For preprocessing.*/

3. Run model.sh  /* Train the model.*/

4. Run generate.sh  /* Generate the test file and the BLEU score.*/

5. Extract the WX-transliterated test file from the file generated after running the generate.sh

6. Run wxtoutf.py to generate test file in utf. /* Convert the WX-transliterated test file to UTF file.*/



For baseline approach:

1. Run preprocess.sh /* For preprocessing.*/

2. Run model.sh  /* Train the model.*/

3. Run generate.sh /* Generate the test file and the BLEU score.*/



For SMT+WX approach:

1. Run utftowx.py  /* Transliterate the text to WX-notation.*/

2. Follow instructions given in http://www2.statmt.org/moses/?n=Moses.Baseline /* For preprocessing, model training, tuning and testing.*/

3. Run wxtoutf.py to generate test file in utf. /* Convert the WX-transliterated test file to UTF file.*/



For SMT approach:

1. Follow instructions given in http://www2.statmt.org/moses/?n=Moses.Baseline /* For preprocessing, model training, tuning and testing.*/
 

To compute chrF2, TER and WER:

1. Run sacrebleu --metrics {chrf,ter,wer} -tok 'none' -s 'none' \path_of_Reference_file < \path_of_generated_file



