#ifndef _POLYKERNEL_H___
#define _POLYKERNEL_H___

#include "lib/common.h"
#include "kernel/RealKernel.h"
#include "features/RealFeatures.h"

class CPolyKernel: public CRealKernel
{
 public:
  CPolyKernel(LONG size, INT degree, bool inhomogene, bool use_normalization=true);
  ~CPolyKernel();
  
  virtual bool init(CFeatures* l, CFeatures* r, bool do_init);
  virtual void cleanup();

  /// load and save kernel init_data
  virtual bool load_init(FILE* src);
  virtual bool save_init(FILE* dest);

  // return what type of kernel we are Linear,Polynomial, Gaussian,...
  virtual EKernelType get_kernel_type() { return K_POLY; }

  // return the name of a kernel
  virtual const CHAR* get_name() { return "Poly"; };

 protected:
  /// compute kernel function for features a and b
  /// idx_{a,b} denote the index of the feature vectors
  /// in the corresponding feature object
  virtual DREAL compute(INT idx_a, INT idx_b);

 protected:
  INT degree;
  bool inhomogene;

  double* sqrtdiag_lhs;
  double* sqrtdiag_rhs;

  bool initialized;
  bool use_normalization;
};

#endif
