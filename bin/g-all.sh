#!/usr/bin/env sh

generate-module --mod-name='GeneralCatagory' --ucd-cat='Ll,Lu,Lo,Nd,Lm,Mn,Mc' UCD

generate-module --mod-name='JoinControl' --prl-cat='Join_Control' PRL

generate-module --mod-name='OldHangulJamo' --hst-cat='V,T,L' HST
