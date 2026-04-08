crashbackups stop
drc off
gds read /foss/designs/inv_test.gds
load inv_test
select top cell
extract path /foss/designs
extract no capacitance
extract no coupling
extract no resistance
extract no length
extract all
ext2spice lvs
ext2spice -p /foss/designs -o /foss/designs/inv_test.ext.spc
quit -noprompt
