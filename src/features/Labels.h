#ifndef _LABELS__H__
#define _LABELS__H__

#include "lib/common.h"
#include "lib/io.h"

class CLabels
{
	public:
		CLabels(INT num_labels);
		CLabels(CHAR* fname);
      CLabels(){;}
		~CLabels();

		bool load(CHAR* fname);
		bool save(CHAR* fname);

		/// set/get the labels
		inline bool set_label(INT idx, DREAL label)
		{ 
			if (labels && idx<num_labels)
			{
				labels[idx]=label;
				return true;
			}
			else 
				return false;
		}

		/// set/get INT label
		inline bool set_int_label(INT idx, INT label)
		{ 
			if (labels && idx<num_labels)
			{
				labels[idx]= (DREAL) label;
				return true;
			}
			else 
				return false;
		}

		inline DREAL get_label(INT idx)
		{
			if (labels && idx<num_labels)
				return labels[idx];
			else
				return -1;
		}

		inline INT get_int_label(INT idx)
		{
			if (labels && idx<num_labels)
			{
				ASSERT(labels[idx]== ((DREAL) ((INT) labels[idx])));
				return ((INT) labels[idx]);
			}
			else
				return -1;
		}

		/// get label vector
		/// caller has to clean up
		DREAL* get_labels(INT &len) ;

		/// get INT label vector
		/// caller has to clean up
		INT* get_int_labels(INT &len) ;

		/// set INT label vector
		/// caller has to clean up
		void set_int_labels(INT *labels, INT len) ;

		/// get number of labels
		inline INT get_num_labels() { return num_labels; }
	protected:
		INT num_labels;
		DREAL* labels;
};
#endif
