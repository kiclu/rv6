// Instruction cache structure
`define imem_struct_set_assoc
// `define imem_struct_full_assoc
// `define imem_struct_direct

// Instruction cache line size in bits
`define imem_line 512
`define imem_offs_len $clog2(`imem_line/8)

// Set associative L1i cache parameter configuration
`ifdef imem_struct_set_assoc
    // Set count
    `define imem_sets 2
    `define imem_set_len $clog2(`imem_sets)

    // Ways per set
    `define imem_ways 2
    `define imem_way_len $clog2(`imem_ways)
    
    `define imem_tag_len (64 - `imem_set_len - `imem_offs_len)
`endif

// Data cache structure
`define dmem_struct_set_assoc
// `define dmem_struct_full_assoc
// `define dmem_struct_direct

// Data cache line size in bits
`define dmem_line 128
`define dmem_offs_len $clog2(`dmem_line/8)

// Set associative L1d cache parameter configuration
`ifdef dmem_struct_set_assoc
    // Set count
    `define dmem_sets 4
    `define dmem_set_len $clog2(`dmem_sets)

    // Ways per set
    `define dmem_ways 4
    `define dmem_way_len $clog2(`dmem_ways)
    
    `define dmem_tag_len (64 - `dmem_set_len - `dmem_offs_len)
`endif
