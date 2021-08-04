// DESCRIPTION: Verilator: Verilog example module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2017 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0
//======================================================================

// Include common routines
#include <verilated.h>

// Include model header, generated from Verilating "top.v"
#include "Vtop_tb.h"

#include <queue>
#include <cstdint>

#include <sstream>

// Current simulation time (64-bit unsigned)
vluint64_t main_time = 0;
// Called by $time in Verilog
double sc_time_stamp() {
    return main_time;  // Note does conversion to real, to match SystemC
}

int main(int argc, char** argv, char** env) {
    // This is a more complicated example, please also see the simpler examples/make_hello_c.

    // Prevent unused variable warnings
    if (false && argc && argv && env) {}

    // Set debug level, 0 is off, 9 is highest presently used
    // May be overridden by commandArgs
    Verilated::debug(0);

    // Randomization reset policy
    // May be overridden by commandArgs
    Verilated::randReset(2);

    // Verilator must compute traced signals
    Verilated::traceEverOn(true);

    // Pass arguments so Verilated code can see them, e.g. $value$plusargs
    // This needs to be called before you create any model
    Verilated::commandArgs(argc, argv);

    // Create logs/ directory in case we have traces to put under it
    Verilated::mkdir("logs");

    // Construct the Verilated model, from Vtop.h generated from Verilating "top.v"
    Vtop_tb* top = new Vtop_tb;  // Or use a const unique_ptr, or the VL_UNIQUE_PTR wrapper

    // Set some inputs
    top->rst = 0;
    top->clk = 0;

    // Simulate until $finish
    while (!Verilated::gotFinish()) {
        main_time++;  // Time passes...

        // Toggle a fast (time/2 period) clock
        top->clk = !top->clk;

        if (!top->clk) {
            if (main_time > 1 && main_time < 10) {
                top->rst = 1;  // Assert reset
            } else {
                top->rst = 0;  // Deassert reset
            }
        }


        // Evaluate model
        // (If you have multiple models being simulated in the same
        // timestep then instead of eval(), call eval_step() on each, then
        // eval_end_step() on each.)
        top->eval();

        if(main_time > 80) { // timeout the simulation
            fprintf(stderr, "\n\nERROR! The simulation timed out!\n\n\n");
            break;
        }

    }

    // Final model cleanup
    top->final();

    //  Coverage analysis (since test passed)
#if VM_COVERAGE
    Verilated::mkdir("logs");
    VerilatedCov::write("logs/coverage.dat");
#endif

    // Destroy model
    delete top;
    top = nullptr;

    // Fin
    exit(0);
}
