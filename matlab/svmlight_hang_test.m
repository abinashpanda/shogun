ww(1) = 0.001;
ww(2) = 0.005;
ww(3) = 0.01;
ww(4) = 0.05;
ww(5) = 0.1;
ww(6) = 1;
ww(7) = 10;
ww(8) = 50;
ww(9) = 100;
ww(10) = 1000;

C = 1;
cache_size=50;
svm_eps=1e-5;
mkl_eps=1e-3;
svm_tube=0.01;

beta = [0:20];

n = 3000;
k = 10;
noise = 0;


kk=15;
[dat,lab] = gen_ueberlagerung(n,beta(kk));
ii=randperm(n);
rand('seed',0);
traindat=dat(ii(1:n/3));
trainlab=lab(ii(1:n/3));
valdat=dat(ii(n/3+1:2*n/3));
vallab=lab(ii(n/3+1:2*n/3));
testdat=dat(ii(2*n/3+1:end));
testlab=lab(ii(2*n/3+1:end));

%traindat=rand(100,1000);
%trainlab=2*round(rand(1,1000))-1;
%valdat=rand(100,1000);
%vallab=2*round(rand(1,1000))-1;


tic
err=[];
idx=0;
i=1;
j=2;
k=3;

w1=ww(i);
w2=ww(j);
w3=ww(k);
gf('send_command', 'loglevel ALL');
gf('send_command', 'clean_features TRAIN' );
gf('send_command', 'clean_features TEST' );
gf('send_command', 'clean_kernels');
gf('send_command', 'new_svm SVRLIGHT');
%gf('send_command', 'new_svm LIGHT');
gf('send_command', 'use_mkl 0');
gf('send_command', 'use_precompute 1');
gf('send_command', sprintf('mkl_parameters %f 0',mkl_eps));
gf('send_command', sprintf('c %f',C));
gf('send_command', sprintf('svm_epsilon %f',svm_eps));
gf('send_command', sprintf('svr_tube_epsilon %f',svm_tube));
gf('set_labels','TRAIN', trainlab);
gf('add_features','TRAIN', traindat);
gf('add_features','TRAIN', traindat);
gf('add_features','TRAIN', traindat);
gf('send_command', sprintf('set_kernel COMBINED %d', cache_size));
gf('send_command', sprintf('add_kernel 1 GAUSSIAN REAL %d %f', cache_size, w1));
gf('send_command', sprintf('add_kernel 1 GAUSSIAN REAL %d %f', cache_size, w2));
gf('send_command', sprintf('add_kernel 1 GAUSSIAN REAL %d %f', cache_size, w3));
gf('send_command', 'init_kernel TRAIN');
gf('send_command', 'svm_train');

gf('add_features','TEST', valdat);
gf('add_features','TEST', valdat);
gf('add_features','TEST', valdat);
gf('send_command', 'init_kernel TEST');
out=gf('svm_classify');
idx=idx+1;
err(idx).out=out;
err(idx).w1=w1;
err(idx).w2=w2;
err(idx).w3=w3;
toc

tic
err=[];
idx=0;
i=1;
j=2;
k=3;

w1=ww(i);
w2=ww(j);
w3=ww(k);
gf('send_command', 'loglevel ALL');
gf('send_command', 'clean_features TRAIN' );
gf('send_command', 'clean_features TEST' );
gf('send_command', 'clean_kernels');
gf('send_command', 'new_svm LIBSVR');
%gf('send_command', 'new_svm LIBSVM');
gf('send_command', 'use_mkl 0');
gf('send_command', 'use_precompute 1');
gf('send_command', sprintf('mkl_parameters %f 0',mkl_eps));
gf('send_command', sprintf('c %f',C));
gf('send_command', sprintf('svm_epsilon %f',svm_eps));
gf('send_command', sprintf('svr_tube_epsilon %f',svm_tube));
gf('set_labels','TRAIN', trainlab);
gf('add_features','TRAIN', traindat);
gf('add_features','TRAIN', traindat);
gf('add_features','TRAIN', traindat);
gf('send_command', sprintf('set_kernel COMBINED %d', cache_size));
gf('send_command', sprintf('add_kernel 1 GAUSSIAN REAL %d %f', cache_size, w1));
gf('send_command', sprintf('add_kernel 1 GAUSSIAN REAL %d %f', cache_size, w2));
gf('send_command', sprintf('add_kernel 1 GAUSSIAN REAL %d %f', cache_size, w3));
gf('send_command', 'init_kernel TRAIN');
gf('send_command', 'svm_train');

gf('add_features','TEST', valdat);
gf('add_features','TEST', valdat);
gf('add_features','TEST', valdat);
gf('send_command', 'init_kernel TEST');
out=gf('svm_classify');
idx=idx+1;
err(idx).out=out;
err(idx).w1=w1;
err(idx).w2=w2;
err(idx).w3=w3;
toc
