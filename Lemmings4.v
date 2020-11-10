module Lemming4(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 


    parameter LEFT = 3'd0, 
              RIGHT = 3'd1,
              DIG_L = 3'd2,
              DIG_R = 3'd3,
              FALL_L = 3'd4,
              FALL_R = 3'd5,
              SPLAT = 3'd6; // 太高了 摔碎了

    reg [2:0] state, next_state;
    reg [31:0] count;
    
    always @(state) begin
        case(state)
            LEFT:begin
                if(!ground)
                    next_state = FALL_L;
                else if(dig)
                    next_state = DIG_L;
                else if(bump_left)
                    next_state = RIGHT;
                else 
                    next_state = LEFT;
            end
            RIGHT:begin
                if(!ground)
                    next_state = FALL_R;
                else if(dig)
                    next_state = DIG_R;
                else if(bump_right)
                    next_state = LEFT;
                else 
                    next_state = RIGHT;
            end
            DIG_L: next_state = ground ? DIG_L : FALL_L;
            DIG_R: next_state = ground ? DIG_R : FALL_R;
            FALL_L: 
            begin
                if(ground)
                    next_state = count > 31'd19 ? SPLAT : LEFT;
                else
                    next_state = FALL_L;

            end
            FALL_R:  
            begin
                if(ground)
                    next_state = count > 31'd19 ? SPLAT : RIGHT;
                else
                    next_state = FALL_R;

            end
            SPLAT : next_state = SPLAT;
            default: next_state = LEFT;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if(areset)
            state <= LEFT;   
        else
        begin
            if(state == FALL_L || state == FALL_R)
                count <= count + 1;
            else
                count <= 0;

            state <= next_state;  
        end 
            
    end

    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_R || state == FALL_L);
    assign digging = (state == DIG_L || state == DIG_R);

endmodule