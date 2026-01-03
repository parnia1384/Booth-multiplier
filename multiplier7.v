`timescale 1ns/1ns
module multiplier7(
    clk,start,A,B,Product, ready
    );
    parameter n = 31;
    parameter n1 = 2 * ((n + 1) / 2);
    input start, clk;
    output ready;
    output reg [(2 * n1 - 1):0] Product;
    input wire [(n - 1):0] A, B;

    reg [6:0] counter;
    reg [(2 * ((n - 1) / 2) + 1):0] save_A;
    reg [n1:0] two;
    reg [(n1 + 1):0] adder_output;
    reg save_LSB;
    assign ready = (counter == ((n + 1) / 2)) ? 1 : 0;
    
    always @ (posedge clk) begin
        if(start) begin
            counter <= 0;
            Product <= (n % 2 == 0) ? {{n{1'b0}}, B} : {{n1{1'b0}}, B[n - 1], B};
            save_A <= (n % 2 == 0) ? (A) : ({A[n - 1], A});
            two <= (n % 2 == 0) ? (A << 1) : ({A[n - 1], A, 1'b0});
            save_LSB <= 0;
        end
        else if(!ready) begin
            counter <= counter + 1;
            save_LSB <= Product[1];
            Product <= {adder_output, Product[(n1 - 1):2]};
        end
    end
    always @ (*) begin
        case({Product[1:0],save_LSB})
        3'b000 : adder_output = ({{2{Product[(2 * n1 - 1)]}}, Product[(2 * n1 - 1):n1]});
        3'b001 : adder_output = ({{2{Product[(2 * n1 - 1)]}}, Product[(2 * n1 - 1):n1]} + {{2{save_A[(2 * ((n - 1) / 2) + 1)]}},save_A});
        3'b010 : adder_output = ({{2{Product[(2 * n1 - 1)]}}, Product[(2 * n1 - 1):n1]} + {{2{save_A[(2 * ((n - 1) / 2) + 1)]}},save_A});
        3'b011 : adder_output = ({{2{Product[(2 * n1 - 1)]}}, Product[(2 * n1 - 1):n1]} + {two[n1],two});
        3'b100 : adder_output = ({{2{Product[(2 * n1 - 1)]}}, Product[(2 * n1 - 1):n1]} - {two[n1], two});
        3'b101 : adder_output = ({{2{Product[(2 * n1 - 1)]}}, Product[(2 * n1 - 1):n1]} - {{2{save_A[(2 * ((n - 1) / 2) + 1)]}},save_A});
        3'b110 : adder_output = ({{2{Product[(2 * n1 - 1)]}}, Product[(2 * n1 - 1):n1]} - {{2{save_A[(2 * ((n - 1) / 2) + 1)]}},save_A});
        3'b111 : adder_output = ({{2{Product[(2 * n1 - 1)]}}, Product[(2 * n1 - 1):n1]});
    endcase
    end
endmodule