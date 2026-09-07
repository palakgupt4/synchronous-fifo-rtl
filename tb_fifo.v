`timescale 1ns / 1ps

module tb_fifo;

reg clk;
reg reset;
reg write_en;
reg read_en;
reg [7:0] write_data;

wire [7:0] read_data;
wire full;
wire empty;

reg [7:0] expected_data;


// DUT
fifo uut (
    .clk(clk),
    .reset(reset),
    .write_en(write_en),
    .read_en(read_en),
    .write_data(write_data),
    .read_data(read_data),
    .full(full),
    .empty(empty)
);


// CLOCK
always #5 clk = ~clk;


// TEST
initial
begin

    clk = 0;
    reset = 1;
    write_en = 0;
    read_en = 0;
    write_data = 0;
    expected_data = 0;


    // TEST 1: RESET

    #20;

    reset = 0;

    $display("RESET DONE");


    // TEST 2: WRITE

    write_en = 1;

    write_data = 8'd10;
    #10;

    write_data = 8'd20;
    #10;

    write_data = 8'd30;
    #10;

    write_en = 0;

    $display("WRITE TEST DONE");


    // TEST 3: READ 10

    expected_data = 8'd10;

    read_en = 1;

    #10;

    if (read_data == expected_data)
        $display("PASS: Expected = %d, Received = %d",
                 expected_data, read_data);
    else
        $display("FAIL: Expected = %d, Received = %d",
                 expected_data, read_data);


    // TEST 4: READ 20

    expected_data = 8'd20;

    #10;

    if (read_data == expected_data)
        $display("PASS: Expected = %d, Received = %d",
                 expected_data, read_data);
    else
        $display("FAIL: Expected = %d, Received = %d",
                 expected_data, read_data);


    // TEST 5: READ 30

    expected_data = 8'd30;

    #10;

    if (read_data == expected_data)
        $display("PASS: Expected = %d, Received = %d",
                 expected_data, read_data);
    else
        $display("FAIL: Expected = %d, Received = %d",
                 expected_data, read_data);

    read_en = 0;


    // TEST 6: EMPTY

    #10;

    if (empty)
        $display("PASS: FIFO is EMPTY");
    else
        $display("FAIL: FIFO should be EMPTY");


    // TEST 7: READ WHILE EMPTY

    read_en = 1;

    #10;

    read_en = 0;

    if (empty)
        $display("PASS: Read blocked because FIFO is EMPTY");
    else
        $display("FAIL: EMPTY condition incorrect");


    // RESET

    reset = 1;

    #10;

    reset = 0;


    // TEST 8: FILL FIFO

    write_en = 1;

    write_data = 8'd1;
    #10;

    write_data = 8'd2;
    #10;

    write_data = 8'd3;
    #10;

    write_data = 8'd4;
    #10;

    write_data = 8'd5;
    #10;

    write_data = 8'd6;
    #10;

    write_data = 8'd7;
    #10;

    write_data = 8'd8;
    #10;

    write_data = 8'd9;
    #10;

    write_data = 8'd10;
    #10;

    write_data = 8'd11;
    #10;

    write_data = 8'd12;
    #10;

    write_data = 8'd13;
    #10;

    write_data = 8'd14;
    #10;

    write_data = 8'd15;
    #10;

    write_data = 8'd16;
    #10;

    write_en = 0;


    // TEST 9: FULL

    #10;

    if (full)
        $display("PASS: FIFO is FULL");
    else
        $display("FAIL: FIFO should be FULL");


    // TEST 10: WRITE WHILE FULL

    write_en = 1;

    write_data = 8'd100;

    #10;

    write_en = 0;

    if (full)
        $display("PASS: Extra WRITE blocked");
    else
        $display("FAIL: FULL condition incorrect");


    // TEST 11: READ 4 VALUES

    read_en = 1;

    #10;
    #10;
    #10;
    #10;

    read_en = 0;

    $display("READ 4 VALUES - SPACE CREATED");


    // TEST 12: POINTER WRAP-AROUND

    write_en = 1;

    write_data = 8'd17;
    #10;

    write_data = 8'd18;
    #10;

    write_data = 8'd19;
    #10;

    write_data = 8'd20;
    #10;

    write_en = 0;

    $display("WRAP-AROUND WRITE DONE");


    // CREATE ONE FREE SPACE

    read_en = 1;

    #10;

    read_en = 0;

    $display("ONE FIFO LOCATION FREED");


    // TEST 13: SIMULTANEOUS READ + WRITE

    expected_data = 8'd6;

    write_en = 1;
    read_en = 1;

    write_data = 8'd50;

    #10;

    if (read_data == expected_data)
        $display("PASS: Simultaneous R/W - Expected = %d, Received = %d",
                 expected_data, read_data);
    else
        $display("FAIL: Simultaneous R/W - Expected = %d, Received = %d",
                 expected_data, read_data);

    write_en = 0;
    read_en = 0;


    // END

    #20;

    $display("=================================");
    $display("FIFO TESTBENCH COMPLETE");
    $display("=================================");

    $finish;

end

endmodule