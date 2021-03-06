function similarity=gaussianSimilarity(x, binNum, plotOpt)
%gaussianSimilarity: Evaluation of a data set to see if it is close to a 1D Gaussian distribution
%
%	Usage:
%		similarity=gaussianSimilarity(x, binNum)
%		similarity=gaussianSimilarity(x, binNum, plotOpt)
%
%	Description:
%		similarity=gaussianSimilarity(x, binNum) return the similarity of the dataset being generated by a 1D Gaussian PDF
%
%	Example:
%		dataNum=1000;
%		x=randn(dataNum, 1);
%		subplot(2,1,1);
%		gaussianSimilarity(x, 20, 1);
%		x=rand(dataNum, 1);
%		subplot(2,1,2);
%		gaussianSimilarity(x, 20, 1);

%	Category: Gaussian PDF
%	Roger Jang, 20100731

if nargin<1, selfdemo; return; end
dataNum=length(x);
if nargin<2, binNum=dataNum/50; end
if nargin<3, plotOpt=0; end

gPrm=gaussianMle(x);
x=(x-gPrm.mu)/gPrm.sigma;	% 0 mean, unity variance
[N, X]=hist(x, binNum);

desired=gaussian(X, gPrm);
k=dataNum*(max(x)-min(x))/binNum;
diff=mean(abs(desired-N/k));
similarity=bellmf(diff, [0.1 1 0]);
% 0.28 ---> 0.9
% 0.03 ---> 0.1
%a=4*(0.9-0.1);
%b=0.9-a*0.28;
%similarity=a*similarity+b;

if plotOpt,
	bar(X, N/k, 1);
	range=max(x)-min(x);
	xi=linspace(min(x)-range/2, max(x)+range/2);
	yi=gaussian(xi, gPrm);
	hold on
	h=plot(xi, yi);
	hold off
	set(h, 'linewidth', 2, 'color', 'r');
	fprintf('Average abs. difference = %g, similarity to Gaussian = %g\n', diff, similarity);
end

% ====== Self demo
function selfdemo
mObj=mFileParse(which(mfilename));
strEval(mObj.example);
