
# Distance algorithms

				   
# fingerprint
Lower-cases the strings, tokenizes by non-alphanumeric, and alphabetizes the tokens

|V1                        |V2                        | T1                   | T2                   | match |
|--------------------------|--------------------------|----------------------|----------------------|-------|  
| **Foobar**               | **fooBar**               | foobar               | foobar               | true  |
| **bar foo**              | **foo bar**              | bar foo              | bar foo              | true  |
| **Jon Smith**            | **John Smith**           | jon smith            | john smith           | false |
| **Smith, John**          | **John Smith**           | john smith           | john smith           | true  |
| **Information Builders** | **Information Vuilders** | builders information | information vuilders | false |
            

<br/><br/>            
# ngram-fingerprint
Brakes up the strings into blocks of size 2, and then removes non-alphanumeric and orders 
them alphabetically

|V1                        |V2                          | B1                                   | B2                                   | match |
|--------------------------|----------------------------|--------------------------------------|--------------------------------------|-------|  
| **Foobar**               | **fooBar**                 | arbafooboo                           | arbafooboo                           | true  |
| **bar foo**              | **foo bar**                | arbafooorf                           | arbafooboo                           | false |
| **Jon Smith**            | **John Smith**             | itjominsonsmth                       | hnitjominsohsmth                     | false |
| **Smith, John**          | **John Smith**             | hjhnitjomiohsmth                     | hnitjominsohsmth                     | false |
| **Information Builders** | **Information Vuilders**   | atbudeerfoilinioldmanbnfonorrmrstiui | atdeerfoilinioldmanfnvonorrmrstiuivu | false |


<br/><br/>            
# hamming
Position to position character comparison. A 1 is added to the distance score for every character 
that doesn't match. If the string lengths do not match, the difference size is added to the 
distance score.  

Use hamming for fast comparisons. It can find the minimum number of substitutions.


| V1                 |V2                      | distance |  
| -------------------|------------------------|----------|
| **foobar**         | **foofar**             | 1.0      |
| **foo bar**        | **foo far**            | 1.0      |
| **foo bar**        | **bar foo**            | 6.0      |
| **john smith**     | **smith, john**        | 10.0     |
| **john smith**     | **smith, john w.**     | 13.0     |
| **John w. smith**  | **smith, john w.**     | 14.0     |
| **can\'t**         | **cant**               | 2.0      |
| **abcdef**         | **abcxyz**             | 3.0      |
            
            

<br/><br/>
# levenshtein 
Calculates distance between two strings (number of insertions, deletions and subsitutions required to turn one string 
into the other) and then scales the result based on the longer string  

Use levenshtein to compare short or 1 token strings. Do not use it for columns which contain long strings like description or
addresses. The time complexity of the calculation increases as the strings get longer.



| V1                 |V2                      | distance |  
| -------------------|------------------------|----------|
| **foobar**         | **foofar**             | 1.0      |
| **foo bar**        | **foo far**            | 1.0      |
| **foo bar**        | **bar foo**            | 6.0      |
| **john smith**     | **smith, john**        | 10.0     |
| **john smith**     | **smith, john w.**     | 12.0     |
| **John w. smith**  | **smith, john w.**     | 13.0     |
| **can't**         | **cant**               | 1.0      |
| **abcdef**         | **abcxyz**             | 3.0      |
            

<br/><br/>
# jaccard
Character overlap measurement algorithm. This implementation uses a token 
overlap version which splits up the strings into separate words using any 
non-alphanumeric character. The overlap distance algorithm measures the 
percentage of unique tokens that two strings share (intersection) when 
compared to the total number of unique tokens in both strings.  

Use jaccard to compare Firstname-Lastname and Address fields where order of 
the strings do not matter. Do not use to detect misspellings or typos.  

| V1                 |V2                      | tok | pct  |  
| -------------------|------------------------|-----|------|
| **foobar**         | **foofar**             | 0/2 | 0.0  |
| **foo bar**        | **foo far**            | 2/2 | 1.0  |
| **foo bar**        | **bar foo**            | 2/2 | 1.0  |
| **john smith**     | **smith, john**        | 2/2 | 1.0  |
| **john smith**     | **smith, john w.**     | 2/3 | 0.67 | 
| **John w. smith**  | **smith, john w.**     | 3/3 | 1.0  |
| **can't**         | **cant**               | 0/3 | 0.0  |
| **abcdef**         | **abcxyz**             | 0/2 | 0.0  |
            

<br/><br/>
# jaro  
Character by character comparison that limits matching of the first 
string to a window of characters in the second string based on the length 
of the larger of the two strings.  

It then factors in the number of transpositions or matching letters that 
don't occur in the same order.  


| V1                 |V2                      | distance |  
| -------------------|------------------------|----------|
| **foobar**         | **foofar**             | 0.89     |
| **foo bar**        | **foo far**            | 0.90     |
| **foo bar**        | **bar foo**            | 0.0      |
| **john smith**     | **smith, john**        | 0.64     |
| **john smith**     | **smith, john w.**     | 0.59     |
| **John w. smith**  | **smith, john w.**     | 0.0      |
| **can\'t**         | **cant**               | 0.93     |
| **abcdef**         | **abcxyz**             | 0.67     |
            

<br/><br/>
# jaro-winkler
Character by character comparison that limits matching of the first string to a window of 
characters in the second string based on the length of the larger of the two strings.  

It then factors in the number of transpositions or matching letters that don't occur in the same order.  
It then adjusts its score, favouring strings based on a common prefixes.


| V1                 |V2                      | distance |  
| -------------------|------------------------|----------|
| **foobar**         | **foofar**             | 0.92     |
| **foo bar**        | **foo far**            | 0.94     |
| **foo bar**        | **bar foo**            | 0.0      |
| **john smith**     | **smith, john**        | 0.64     |
| **john smith**     | **smith, john w.**     | 0.59     |
| **John w. smith**  | **smith, john w.**     | 0.0      |
| **can't**         | **cant**               | 0.95     |
| **abcdef**         | **abcxyz**             | 0.77     |



<br/><br/>
# jaro-winkler-tfidf
Character by character comparison that limits matching of the first string to a window of 
characters in the second string based on the length of the larger of the two strings.  

It then factors in the number of transpositions or matching letters that don't occur in the 
same order.  

It then adjusts its score, favouring strings based on a common prefixes.  

Then it calculates Term Frequency - Inverse Document Frequency (TF-IDF). It is a score calculation 
which rewards a terms frequency in a document or sentence but penalizes its frequency in other 
documents or sentences. Therefore this distance calculation is used for tokens / terms.  


| V1                       |V2                | distance |  
| -------------------|------------------------|----------|
| **foobar**         | **foofar**             | 0.92     |
| **foo bar**        | **foo far**            | 0.5      |
| **foo bar**        | **bar foo**            | 1.0      |
| **john smith**     | **smith, john**        | 1.0      |
| **john smith**     | **smith, john w.**     | 0.82     |
| **John w. smith**  | **smith, john w.**     | 1.0      |
| **can\'t**         | **cant**               | 0.67     |
| **abcdef**         | **abcxyz**             | 0.0      |


<br/><br/>
# ppm (prediction partial match)
Given a set of symbols in a stream, it try's to predict the next symbol in the stream. 
See [ppm](http://en.wikipedia.org/wiki/Prediction_by_partial_matching) for a detailed explanation

<br/><br/>
# metaphone
Indexes words by their pronunciation. See [metaphone](http://en.wikipedia.org/wiki/Metaphone)
for a detailed explanation.  

| V1                       |V2                       | metaphone                         | result |  
| -------------------------|-------------------------|-----------------------------------|--------|
| **Foobar**               | **fooBar**              | ( FBR === FBR )                   | true   |  
| **bar foo**              | **foo bar**             | ( BRF === FBR )                   | false  |
| **Jon Smith**            | **John Smith**          | ( JNSM0 === JNSM0 )               | true   |
| **Smith, John**          | **John Smith**          | ( SM0JN === JNSM0 )               | false  |
| **Information Builders** | **Information Vuilders**| ( INFRMXNBLTRS === INFRMXNFLTRS ) | false  |
  
<br/><br/>
# double-metaphone
Indexes words by their pronunciation. See [double-metaphone ](http://en.wikipedia.org/wiki/Metaphone#Double_Metaphone)
for a detailed explanation.  

| V1                       |V2                        | double-metaphone                  | result |  
| -------------------------|------------------------- |-----------------------------------|--------|
| **Foobar**               | **fooBar**               | ( FPR === FPR )                   | true   |  
| **bar foo**              | **foo bar**              | ( PRF === FPR )                   | false  |
| **Jon Smith**            | **John Smith**           | ( JNSM0 === JNSM0 )               | true   |
| **Smith, John**          | **John Smith**           | ( SM0JN === JNSM0 )               | false  |
| **Information Builders** | **Information Vuilders** | ( ANFRMXNPLTRS === ANFRMXNFLTRS ) | false  |
  

<br/><br/>
# metaphone3
Indexes words by their pronunciation. See [metaphone3](http://en.wikipedia.org/wiki/Metaphone#Metaphone_3)
for a detailed explanation.

| V1                       |V2                        | metaphone3                | result |  
| -------------------------|------------------------- |---------------------------|--------|
| **Foobar**               | **fooBar**               | ( FPR === FPR )           | true   |  
| **bar foo**              | **foo bar**              | ( PRF === FPR )           | false  |
| **Jon Smith**            | **John Smith**           | ( JNSM0 === JNSM0 )       | true   |
| **Smith, John**          | **John Smith**           | ( SM0JN === JNSM0 )       | false  |
| **Information Builders** | **Information Vuilders** | ( ANFRMXNP === ANFRMXNF ) | false  |
  

<br/><br/>
# soundex
Indexes words by their pronunciation. See [soundex](http://en.wikipedia.org/wiki/Soundex)
for a detailed explanation.  

| V1                       |V2                        | soundex           | result |  
| -------------------------|------------------------- |-------------------|--------|
| **Foobar**               | **fooBar**               | ( F160 === F160 ) | true   |  
| **bar foo**              | **foo bar**              | ( B610 === F160 ) | false  |
| **Jon Smith**            | **John Smith**           | ( J525 === J525 ) | true   |
| **Smith, John**          | **John Smith**           | ( S532 === J525 ) | false  |
| **Information Builders** | **Information Vuilders** | ( I516 === I516 ) | true   |

<br/><br/>
# cologne-phonetic
Indexes words by their pronunciation. See [cologne-phonetic](http://en.wikipedia.org/wiki/Phonetic_algorithm)
for a detailed explanation.

| V1                       |V2                        | cologne-phonetic                  | result |  
| -------------------------|------------------------- |-----------------------------------|--------|
| **Foobar**               | **fooBar**               | ( 317 === 317 )                   | true   |  
| **bar foo**              | **foo bar**              | ( 173 === 317 )                   | false  |
| **Jon Smith**            | **John Smith**           | ( 06862 === 06862 )               | true   |
| **Smith, John**          | **John Smith**           | ( 8626 === 06862 )                | false  |
[ **Information Builders** | **Information Vuilders** | ( 063762615278 === 063762635278 ) | false  |

<br/><br/>        
# euclidean
The "ordinary" distance between two points. See [euclidean](http://en.wikipedia.org/wiki/Euclidean_distance) 
for a detailed explanation.

<br/><br/><br/><br/>    
