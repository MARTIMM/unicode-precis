#!/usr/bin/env sh

#generate-module --mod-name='GeneralCatagory' --cat='Ll,Lu,Lo,Nd,Lm,Mn,Mc' UCD
#generate-module --mod-name='Controls' --cat='Cc' UCD

#generate-module --mod-name='JoinControl' --cat='Join_Control' PRL
generate-module --mod-name='NonCharCodepoint' --cat='Noncharacter_Code_Point' PRL

#generate-module --mod-name='OldHangulJamo' --cat='V,T,L' HST

#generate-module --mod-name='Unassigned' --cat='Cn' DGC

generate-module --mod-name='Bidi' --cat='*' --table BDI
