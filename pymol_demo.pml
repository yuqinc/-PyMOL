Manuals for all pymol commands can be found at https://pymolwiki.org/index.php/Main_Page
PDB files can be found at http://www.rcsb.org/pdb/home/home.do


fetch 2qsg #read in pdb file 2qsg.pdb from PDB, require internet connection.#
center 2qsg #center the molecule in viewing window#
show cartoon, 2qsg #use cartoon representation for the whole molecule#
hide lines, 2qsg #hide line representation, default when loaded in.#

select rad4, chain A
select rad23, chain X
select dna, chain Y or chain W
select domain1, chain A and resi 123-433
select domain2, chain A and resi 434-490
select domain3, chain A and resi 491-540
select domain4, chain A and resi 541-632

set cartoon_ring_mode,3 #use cartoon rings to represent DNA ring structures.#
set cartoon_nucleic_acid_mode, 1 #trace backbone through C3' of each nt#
show sticks, dna #use stick representation for DNA#

alter resi 594-598, ss='s'
alter resi 606-609, ss='s'
rebuild

# ss, secondary structure 
# for example
# select helix, (ss h)
# select sheet, (ss s)
# You can manually assign secondary stuctures to your protein by 
# alter 96-103/, ss='S'
# alter 96-103/, ss='H'
# alter 96-103/, ss='L'

color red, ss h and rad4 #color rad4 helix in red# 
color yellow, ss s and rad4 #color rad4 beta strand in yellow#
color marine, ss l+'' and rad4 #color rad4 loop in marine#
color gray70, dna
util.cbaw dna #color dna  by atoms with carbon in gray#

#util.cba,  color by atom
#util.cbaw white/gray with carbon in white/grey

h_add 2qsg 
##add H to protein. then use the find -> polar contacts in the Action menu to show hydrogen bonds#

alter all,vdw=vdw+1.4
show surface
set transparency, 0.5
create protein, rad4 or rad23
set dot_solvent, 2
set dot_density, 4
get_area protein

#load interfaceResidues.py from File -> run#
run /PATHtoFILE/interfaceResidues.py
foundResidues = interfaceResidues("2qsg", cA="chain A", cB="chain W", cutoff=1, selName="int1Res") #find residues at DNA and rad4 interface with dASA cutoff at 1A^2.#
dist polar1, chain A, chain W, mode=2
foundResidues = interfaceResidues("2qsg", cA="chain A", cB="chain Y", cutoff=1, selName="int2Res") #find residues at DNA and rad4 interface with dASA cutoff at 1A^2.#
dist polar2, chain A, chain Y, mode=2

show sticks, int*Res and rad4 #show the dna contacting aa in sticks, showing sidechains.#
util.cbam int*Res and rad4 #color the dna contacting aa by atom type with carbon in magentas.#
alter all,vdw=vdw-1.4
hide everything, protein
color white, protein
show surface, protein


#Quick movie making#
mset 1 x50
frame 1
mview store
frame 10
zoom (resi 556,596-607)
orient (resi 556,596-607)
mview store
frame 20
#manually choose view#
mview store
frame 30
#manually choose view#
mview store
frame 40
#manually choose view#
mview store
frame 50
#manually choose view#
mview store
set ray_trace_frames=1
set cache_frames=0
mclear
mpng test_mov
