#! perl

use Test2::V0;
use Math::Random qw(:all);

random_set_seed_from_phrase( 'En arkhe en ho Logos' );

{
    my @seeds = random_get_seed;
    skip_all 'original phrtsd detected; these tests require the new version'
      unless ( $seeds[0] == 964_304_455 && $seeds[1] == 841_103_996 );
}


sub fcheck {
    [ map { float( $_, precision => 5 ) } @_ ]
}

#------ TESTS
# NOTE:  Do not change the order of these tests!!  Since at least
# one new variate is produced every time, the results will differ
# if the order is changed.  If new tests have to be added, add them
# at the end.

is(
    [ random_uniform( 3, 0, 1.5 ) ],    #
    fcheck( 0.05617, 0.51721, 0.83203 ),
    'random_uniform',
);

is(
    [ random_uniform_integer( 3, 1, 999_999 ) ],    #
    [ 134_416, 581_232, 488_982 ],
    'random_uniform_integer'
);

is(                                                 #
    [ random_permutation( qw[A 2 c iv E 6 g viii] ) ],
    [qw( A g E 6 viii 2 c iv )],
    'random_permutation',
);

is(                                                 #
    [ random_permuted_index( 9 ) ],
    [ 3, 7, 6, 8, 1, 0, 2, 5, 4 ],
    'random_permuted_index'
);

is(                                                 #
    [ random_normal( 3, 50, 2.3 ) ],
    fcheck( 51.32045, 52.86931, 51.42714 ),
    'random_normal',
);

is(                                                 #
    [ random_chi_square( 3, 4 ) ],
    fcheck( 3.06391, 2.69547, 3.06120 ),
    'random_chi_square',
);

is(                                                 #
    [ random_f( 3, 2, 5 ) ],
    fcheck( 20.49306, 1.76842, 0.18747 ),
    'random_f',
);

is(                                                 #
    [ random_beta( 3, 17, 23 ) ],
    fcheck( 0.42553, 0.39371, 0.35722 ),
    'random_beta',
);

is(                                                 #
    [ random_binomial( 3, 31, 0.43 ) ],
    [ 14, 13, 10 ],
    'random_binomial',
);

is(                                                 #
    [ random_poisson( 3, 555 ) ],
    [ 510, 557, 536 ],
    'random_poisson',
);

is(                                                 #
    [ random_exponential( 3, 444 ) ],
    fcheck( 127.98662, 8.24119, 397.19221 ),
    'random_exponential',
);

is(                                                 #
    [ random_gamma( 3, 11, 4 ) ],
    fcheck( 0.47858, 0.32865, 0.56708 ),
    'random_gamma',
);

is(                                                 #
    [ random_multinomial( 3, 0.1, 0.72, 0.18 ) ],
    [ 0, 2, 1 ],
    'random_multinomial',
);

is(                                                 #
    [ random_negative_binomial( 3, 10, 0.63 ) ],
    [ 0, 2, 5 ],
    'random_negative_binomial',
);

is(                                                 #
    [ random_multivariate_normal( 2, 1, 1, [ 0.1, 0.0 ], [ 0.0, 0.1 ] ) ],
    [
        fcheck( -0.0607633190045207, 0.893369401623808 ), fcheck( 1.51427988386676, 0.887689416564967 ),
    ],
    'random_multivariate_normal',
);

done_testing;
