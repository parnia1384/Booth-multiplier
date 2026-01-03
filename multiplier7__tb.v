`timescale 1ns/1ns

module multiplier7__tb();

   parameter no_of_tests = 10000;
   parameter nb = 63;
   parameter n1 = 2 * ((nb + 1) / 2);
//------------------generating clock signal in 100MHz
   reg clk = 1'b1;
   always @(clk)
      clk <= #5 ~clk;
//-----------------------------------------------------
 
//-------------------------------------- reg declaration 
   reg start;
   reg signed [nb - 1:0] A, B, C, D;
   reg signed [(2*n1 - 1):0] expected_product;
//----------------------------------------------------------    
   integer i, j, err = 0;
   
   initial begin
      start = 0;

      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      #1;
//------------------------------------------repeat the test no_of_tests times with different random numbers
      for(i=0; i<no_of_tests; i=i+1) begin
         A = $random();
         B = $random();
         if(nb > 31) begin
         A = { $urandom(), $urandom() };
         B = { $urandom(), $urandom() };
         end
         expected_product = A * B;
         C = A;
         D = B;
      //----------------------------------generating start signal -------------------------------------------------------------     
         start = 1;
         @(posedge clk);
         #1;
         start = 0;
         A = 'bx; //When start became "1" we register A & B and their changes is not important after start became "0"
         B = 'bx; //When start became "1" we register A & B and their changes is not important after start became "0"
      //----------------------------------------------------------------------------------------------------------------------
         
      //-----------------------------------wait until multiplication become complete
         for(j=0; j<=(n1/2); j=j+1)        
            @(posedge clk);
         @(posedge clk);
      //------------------------------------------------------------------------------

         $write   ("%x (%0d) x %x (%0d) = %x (%0d) ", C, C, D, D, uut.Product, $signed(uut.Product));

         if (expected_product === uut.Product)
            $display(", OK");
         else 
            $display (", ERROR: expected %x, got %x", expected_product, uut.Product); 

      end

      $stop;
   end


    multiplier7 uut (        
        .clk(clk),
        .start(start),
        .A(A),
        .B(B),
        .Product(),
      .ready()
    );


endmodule