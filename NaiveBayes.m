%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Naive Bayes- Min Max normalization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Min-Max Normalized Training Set
training = csvread('D:\UCLA courses\W15\249\Project\dataset\March6\TrainDataNorm.csv',1,0,[1, 0,15120,11]);
%Min-Max Normalized Training Set classes
class = csvread('D:\UCLA courses\W15\249\Project\dataset\March6\TrainDataNorm.csv',1,12,[1, 12,15120,12]);
%Min-Max Normalized Test Set data 
test = csvread('D:\UCLA courses\W15\249\Project\dataset\March6\TestDataNorm.csv',1,1,[1, 1,565892,12]);

%Calling naive-bayes classifier in MATLAB
naive_class_one  = classify(test.*1000000,training.*1000000, class.*1000000, 'diaglinear');

%Denormalizing the test set class results received
norm= naive_class_one.*7;
result=ceil(norm);
result(result==0)=1;

%Comparing the found classes with the dataset answers
ucicompare = csvread('D:\UCLA courses\W15\249\Project\dataset\March6\UCIDataNorm.csv',15121,12,[15121, 12,581012,12]);
ucicompare=ucicompare.*1000000;
ucicompare = ucicompare .*7;
ucicompare=ceil(ucicompare);
ucicompare(ucicompare==0)=1;

%Accuracy calculation
difference=ucicompare-result;
difference=abs(difference);
count=length(find(difference>0));
total_values=size(result);
num_count=total_values-count;
accuracy=num_count/total_values

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Z-score normalization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Loading the original training set 
original_training = csvread('D:\UCLA courses\W15\249\Project\dataset\March6\TrainData.csv',1,0,[1, 0,15120,11]);
%Loading the original classes of the training set
original_class = csvread('D:\UCLA courses\W15\249\Project\dataset\March6\TrainData.csv',1,12,[1, 12,15120,12]);
%Loading the original test set
original_test = csvread('D:\UCLA courses\W15\249\Project\dataset\March6\TestData.csv',1,1,[1, 1,565892,12]);

%COmputing z-score normalizatons of all the above three matrices
z_training= zscore(original_training,1);
z_class= zscore(original_class,1);
z_test= zscore(original_test,1);

%Calling naive-bayes classifier in MATLAB
naive_class_two  = classify(z_test,z_training, z_class, 'diaglinear');

%Saving the result
z_result=naive_class_two;

%Comparing the found classes with the dataset answers
z_ucicompare1 = csvread('D:\UCLA courses\W15\249\Project\dataset\March6\UCIData.csv',15121,12,[15121, 12,581012,12]);
z_ucicompare= zscore(z_ucicompare1,1);
z_ucicompare=z_ucicompare.*2;
z_ucicompare=round(z_ucicompare);
z_ucicompare=z_ucicompare./2;
z_ucicompare(z_ucicompare==-0.5)=-1.5;
z_ucicompare(z_ucicompare==0)=-1.0;
z_ucicompare(z_ucicompare==0.5)=-0.5;
z_ucicompare(z_ucicompare==1.5)=0;
z_ucicompare(z_ucicompare==2.0)=0.5;
z_ucicompare(z_ucicompare==3.0)=1.0;
z_ucicompare(z_ucicompare==3.5)=1.5;

%Accuracy calculation
z_difference=z_ucicompare-z_result;
z_difference=abs(z_difference);
z_count=length(find(z_difference>0));
z_total_values=size(z_result);
z_num_count=z_total_values-z_count;
z_accuracy=z_num_count/z_total_values

