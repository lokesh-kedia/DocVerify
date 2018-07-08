# DocVerify
This Is A Machine Learning Algorithm Using Logistic Regression With Gradient Descent , Based On Octave .It Identifies Aadhar Number from a Scanned Copy /Photograph Of It And Convert To Text.

DocVerify
This Is A Machine Learning Algorithm Using Logistic Regression With Gradient Descent , Based On Octave .It Identifies Aadhar Number from a Scanned Copy /Photograph Of It And Convert To Text. Which Can Be Further Used To Verify Originality Of Aadhar Card , We Have Used A Complex Image Processing Algorithm To Extract The Number. 
The Function Used In Project :
1. main.m:   main('ImageName') 
Loading the trained data , calling functions for ML , and Image processing.
2.onevsall.m:[all_theta]=onevsall(X,y,num_labels,lambda)
It determines the theta for cost function
3. lrcostfunction.m: =[J grad]=lrcostfunction(theta,X,y,lambda)
It calculates cost function and gradient descent
4.predictOneVsAll.m: p = predictOneVsAll(all_theta, X)
It finally predicts the output(with 99.99% accuracy)
5.ocr.m , ImageTo20x20Gray.m , ImageTo20x20Gray_1.m, divider.m = These functions are used for Image processing and extracting the Image.

How To Run The Project:
Run command - main(ImageName.ext) 
Example: main("CTest1.jpg");
for Testing Use "CTest1.jpg" And "CTest2.jpg"

Team: QuadSquad 
By: 
Mohit Agarwal
Lokesh Kedia

