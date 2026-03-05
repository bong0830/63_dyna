*SECTION_SOLID
$ secid,elform
1,1

*SECTION_SHELL
$ secid,elform,shrf,nip
2,2,0.8333,5
$ t1,t2,t3,t4
2.0,2.0,2.0,2.0

*MAT_PIECEWISE_LINEAR_PLASTICITY
$ mid,ro,e,pr,sigy,etan,fail,tdel
1,7.85e-9,210000.0,0.30,450.0,1200.0,0.25,0.0

*MAT_RIGID
$ mid,ro,e,pr
2,7.85e-9,210000.0,0.30

*MAT_RIGID
$ mid,ro,e,pr
3,7.85e-9,210000.0,0.30

*PART
Plate
$ pid,secid,mid,eosid,hgid,grav,adpopt,tmid
1,1,1,0,0,0,0,0

*PART
Punch_Rigid
$ pid,secid,mid,eosid,hgid,grav,adpopt,tmid
2,2,2,0,0,0,0,0

*PART
Die_Rigid
$ pid,secid,mid,eosid,hgid,grav,adpopt,tmid
3,2,3,0,0,0,0,0
