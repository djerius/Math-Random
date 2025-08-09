#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#ifdef __cplusplus
}
#endif

#include "randlib.h"
#include "helper.h"

#define PERL_VERSION_ATLEAST(a,b,c)                            \
  (PERL_REVISION > (a)                                         \
   || (PERL_REVISION == (a)                                    \
       && (PERL_VERSION > (b)                                  \
           || (PERL_VERSION == (b) && PERL_SUBVERSION >= (c)))))

#if PERL_VERSION_ATLEAST (5,8,1)
/* For whatever reason, the random seeds need to be in 1..2^30; the below will
 * be uniformly distributed assuming the seed value is uniformly distributed.
 *
 * This approach isn't cryptographically secure. Consider using /dev/random
 * or Math::TrulyRandom to get some real entropy.
 */
#define Perl_get_seed (long)(Perl_seed(aTHX) % 1073741824L)
#else
/* If we don't support seeds, return 0 so we can fall back to localtime for
 * default seeding. There's a chance Perl_seed will return 0 and mask this,
 * but in that case the data should still be "random enough" anyway.
 */
#define Perl_get_seed 0L
#endif /* Perl_seed */

MODULE = Math::Random		PACKAGE = Math::Random		

long
get_seed()
       CODE:
       RETVAL = Perl_get_seed;
       OUTPUT:
       RETVAL

double
genbet (aa,bb)
	INPUT:
	double  aa
	double  bb

double
genchi (df)
	INPUT:
	double  df

double
genexp (av)
	INPUT:
	double  av

double
genf (dfn,dfd)
	INPUT:
	double  dfn
	double  dfd

double
gengam (a,r)
	INPUT:
	double  a
	double  r

int
psetmn (p)
	INPUT:
	long  p

int
pgenmn ()
	PROTOTYPE:
	INPUT:
	CODE:
	RETVAL = pgenmn();
	OUTPUT:
	RETVAL

int
rspriw (size)
	INPUT:
	long  size

int
rsprfw (size)
	INPUT:
	long  size

void
svprfw (index,value)
	INPUT:
	long  index
	double  value

void
pgnmul (n,ncat)
	INPUT:
	long  n
	long  ncat

long
gvpriw (index)
	INPUT:
	long  index

double
gennch (df,xnonc)
	INPUT:
	double  df
	double  xnonc

double
gennf (dfn,dfd,xnonc)
	INPUT:
	double  dfn
	double  dfd
	double  xnonc

double
gennor (av,sd)
	INPUT:
	double  av
	double  sd

void
pgnprm (n)
	PROTOTYPE: $
	INPUT:
	long  n
	CODE:
	pgnprm(n);
	OUTPUT:

double
genunf (low,high)
	INPUT:
	double  low
	double  high

long
ignpoi (mu)
	INPUT:
	double  mu

long
ignuin (low,high)
	INPUT:
	long  low
	long  high

long
ignnbn (n,p)
	INPUT:
	long  n
	double  p

long
ignbin (n,pp)
	INPUT:
	long  n
	double  pp

void
phrtsd (phrase)
	PROTOTYPE: $
	INPUT:
	char *  phrase
	PREINIT:
	long  newseed1;
	long  newseed2;
	PPCODE:
	phrtsd(phrase,&newseed1,&newseed2);
	EXTEND(sp, 2);
	PUSHs(sv_2mortal(newSViv(newseed1)));
	PUSHs(sv_2mortal(newSViv(newseed2)));

void
getsd ()
	PROTOTYPE:
	PREINIT:
	long  newseed1;
	long  newseed2;
	PPCODE:
	getsd(&newseed1,&newseed2);
	EXTEND(sp, 2);
	PUSHs(sv_2mortal(newSViv(newseed1)));
	PUSHs(sv_2mortal(newSViv(newseed2)));

void
salfph (phrase)
	PROTOTYPE: $
	INPUT:
	char *  phrase
	CODE:
	salfph(phrase);
	OUTPUT:

void
setall (iseed1,iseed2)
	PROTOTYPE: $$
	INPUT:
	long  iseed1
	long  iseed2
	CODE:
	setall(iseed1,iseed2);
	OUTPUT:

void
random_advance_state (k)
    long  k
    CODE:
    if ( k < 0 )
        croak("incorrect value for k; must be >=0");
    advnst(k);

void
random_init_generator (isdtyp)
    long  isdtyp
    CODE:
    if ( isdtyp != -1 && isdtyp != 0 && isdtyp != 1)
        croak("incorrect value for isdtyp; must be -1, 0, or 1");
    initgn(isdtyp);

void
random_set_antithetic (qvalue)
    long  qvalue
    CODE:
    setant(qvalue);

long
random_get_generator_num ()
    PREINIT:
      long old_g;
    CODE:
      gscgn(0, &old_g);
      RETVAL = old_g;
    OUTPUT:
      RETVAL

long
random_set_generator_num ( g)
      long g
    PREINIT:
      long old_g;
    CODE:
      if ( g < 1 || g > 32 )
        croak("incorrect value for 'g'; must be 1 <= g <= 32");
      gscgn(0, &old_g);
      RETVAL = old_g;
      gscgn(1, &g);
    OUTPUT:
      RETVAL

long
random_integer ()
    CODE:
      RETVAL = ignlgi();
    OUTPUT:
      RETVAL

double
gvprfw (index)
	INPUT:
	long  index

