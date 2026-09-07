`timescale 1ns / 1ps

module fifo(
    input clk,
    input reset,
    input write_en,
    input read_en,
    input [7:0] write_data,

    output full,
    output reg [7:0] read_data,
    output empty
);

    // FIFO memory: 16 locations, 8 bits each
    reg [7:0] memory [0:15];

    // Pointers
    reg [3:0] write_pointer;
    reg [3:0] read_pointer;

    // Number of elements in FIFO
    reg [4:0] counter;

    // Status flags
    assign empty = (counter == 5'd0);
    assign full  = (counter == 5'd16);


    always @(posedge clk)
    begin

        if (reset)
        begin
            write_pointer <= 4'd0;
            read_pointer  <= 4'd0;
            counter       <= 5'd0;
            read_data     <= 8'd0;
        end

        else
        begin

            // WRITE
            if (write_en && !full)
            begin
                memory[write_pointer] <= write_data;
                write_pointer <= write_pointer + 1'b1;
            end


            // READ
            if (read_en && !empty)
            begin
                read_data <= memory[read_pointer];
                read_pointer <= read_pointer + 1'b1;
            end


            // COUNTER
            // Write only
            if (write_en && !full &&
                !(read_en && !empty))
            begin
                counter <= counter + 1'b1;
            end

            // Read only
            else if (read_en && !empty &&
                     !(write_en && !full))
            begin
                counter <= counter - 1'b1;
            end

            // Both read and write:
            // counter remains unchanged

            // Neither:
            // counter remains unchanged

        end

    end

endmodule