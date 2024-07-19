{ atcoder ? false, problems ? false, optionalAttrs }: {
  test-suite = "{{ manifest_dir }}/testcases/{{ bin_alias }}.yml";
  open = ''["nvim", "-p"] + (.paths | map(.src))'';

  template = {
    src = ''
      #![allow(unused_imports)]

      fn main() {
          todo!();
      }

      use ac_library::ModInt998244353 as Mint;
      use itertools::{iproduct, izip, Itertools as _};
      use num::integer::Integer as _;
      use proconio::{input, marker::*};
      use std::{cmp::Reverse, collections::*};
      use superslice::Ext as _;

      #[macro_export]
      macro_rules! chmax {
          ($a:expr, $b:expr) => {{
              let tmp = $b;
              if $a < tmp {
                  $a = tmp;
                  true
              } else {
                  false
              }
          }};
      }

      #[macro_export]
      macro_rules! chmin {
          ($a:expr, $b:expr) => {{
              let tmp = $b;
              if $a > tmp {
                  $a = tmp;
                  true
              } else {
                  false
              }
          }};
      }

      #[macro_export]
      /// mvec![]
      macro_rules! mvec {
          ($val:expr; ()) => {
              $val
          };
          ($val:expr; ($size:expr $(,$rest:expr)*)) => {
              vec![mvec![$val; ($($rest),*)]; $size]
          };
      }
    '';

    new = {
      edition = "2021";
      dependencies = ''
        # 202301から:
        ac-library-rs = "=0.1.1"
        once_cell = "=1.18.0"
        static_assertions = "=1.1.0"
        varisat = "=0.2.2"
        memoise = "=0.3.2"
        argio = "=0.2.0"
        bitvec = "=1.0.1"
        counter = "=0.5.7"
        hashbag = "=0.1.11"
        pathfinding = "=4.3.0"
        recur-fn = "=2.2.0"
        indexing = { version = "=0.4.1", features = ["experimental_pointer_ranges"] }
        amplify = { version = "=3.14.2", features = ["c_raw", "rand", "stringly_conversions"] }
        amplify_derive = "=2.11.3"
        amplify_num = { version = "=0.4.1", features = ["std"] }
        easy-ext = "=1.0.1"
        multimap = "=0.9.0"
        btreemultimap = "=0.1.1"
        bstr = "=1.6.0"
        az = "=1.2.1"
        glidesort = "=0.1.2"
        tap = "=1.0.1"
        omniswap = "=0.1.0"
        multiversion = "=0.7.2"
        # 202004から続投:
        num = "=0.4.1"
        num-bigint = "=0.4.3"
        num-complex = "=0.4.3"
        num-integer = "=0.1.45"
        num-iter = "=0.1.43"
        num-rational = "=0.4.1"
        num-traits = "=0.2.15"
        num-derive = "=0.4.0"
        ndarray = "=0.15.6"
        nalgebra = "=0.32.3"
        alga = "=0.9.3"
        libm = "=0.2.7"
        rand = { version = "=0.8.5", features = ["small_rng", "min_const_gen"] }
        getrandom = "=0.2.10"
        rand_chacha = "=0.3.1"
        rand_core = "=0.6.4"
        rand_hc = "=0.3.2"
        rand_pcg = "=0.3.1"
        rand_distr = "=0.4.3"
        petgraph = "=0.6.3"
        indexmap = "=2.0.0"
        regex = "=1.9.1"
        lazy_static = "=1.4.0"
        ordered-float = "=3.7.0"
        ascii = "=1.1.0"
        permutohedron = "=0.2.4"
        superslice = "=1.0.0"
        itertools = "=0.11.0"
        itertools-num = "=0.1.3"
        maplit = "=1.0.2"
        either = "=1.8.1"
        im-rc = "=15.1.0"
        fixedbitset = "=0.4.2"
        bitset-fixed = "=0.1.0"
        proconio = { version = "=0.4.5", features = ["derive"] }
        text_io = "=0.1.12"
        rustc-hash = "=1.1.0"
        smallvec = { version = "=1.11.0", features = ["const_generics", "const_new", "write", "union", "serde", "arbitrary"] }

        qitoy-derive = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-dfa = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-dfa-leq = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-dfa-leq_inv = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-dfa-multiple_of = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-dfa-non_zero = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-nfa = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-group = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-math-combi = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-mo = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-prelude = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-prime-check = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-prime-factorize = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-prime-sieve = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-rerooting_dp = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-rolling_hash = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-utils-float2uint = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-potentialized_unionfind = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-red_black_tree = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-ring = { git = "https://github.com/qitoy/qitoylib-rs" }
        qitoy-math-matrix = { git = "https://github.com/qitoy/qitoylib-rs" }
      '';
    };
  };

  new = optionalAttrs atcoder
    {
      kind = "cargo-compete";
      platform = "atcoder";
      path = "./{{ contest }}";
    } // optionalAttrs problems {
    kind = "oj-api";
    platform = "atcoder";
    url = "https://kenkoooo.com/atcoder/#/contest/show/{{ id }}";
    path = "./{{ contest }}";
  };

  test.toolchain = "1.70.0";

  submit = {
    kind = "command";
    args = [
      "cargo"
      "+1.70.0"
      "equip"
      "--exclude-atcoder-202301-crates"
      "--remove"
      "docs"
      "--minify"
      "libs"
      "--mine"
      "github.com/qitoy"
      "--bin"
      "{{ bin_name }}"
    ];
    language_id = "5054";
  };
}
