require './lib/board'
require './lib/player'

describe Board do

    let(:player1) { Player.new('p1', 'X') }
    let(:player2) { Player.new('p2', 'O') }
    let(:board) { Board.new(player1, player2) }
    let(:check_box) { [] }
    let(:board_full) { ['X','O','X','O','X','O','O','X','O']}
    let(:board_not_full) { ['X','O','_','O','X','_','O','X','O']}

    describe '#initialize' do
        it 'checks for a player1' do
            expect(board.player_x).to eql(player1)
        end

        it 'checks for a player2' do
            expect(board.player_o).to eql(player2)
        end

        it 'checks for empty array' do
            expect(board.check_box).to eql(check_box)
        end
    end

    describe '#empty' do
        it 'pushes the _ to check_box' do
            board.empty
            expect(board.check_box).to eql((1..9).collect {'_'})
        end
    end

    describe '#check_box_empty?' do
        context 'when check box is empty' do
            it 'return false' do
                expect(board.check_box_empty?(3)).to eql(false)
            end
        end

        context 'when player is involved' do
            before { board.empty }
            
            it 'return true with no choice' do
                expect(board.check_box_empty?(3)).to eql(true)
            end

            it 'return false if there is choice' do
                board.check_box[3] = 'X'
                expect(board.check_box_empty?(4)).to eql(false)
            end
        end
    end

    describe '#check_box_full?' do
        
        it 'returns true if board is full' do
            board.check_box = board_full
            expect(board.check_box_full?).to eql(true)
        end

        it 'returns false if it has any empty cell' do
            board.check_box = board_not_full
            expect(board.check_box_full?).to eql(false)
        end

        it 'returns false if board is empty' do
            expect(board.check_box_full?).to eql(false)
        end

    end

    describe '#update_display_board' do
        before { board.empty }
        
        it 'returns player symbol if choice is correct ' do
            board.update_display_board(player1, 3)
            expect(board.check_box[2]).to eql(player1.symbol)
        end

        it 'returns nil if choice is not between 1-9' do  
            board.update_display_board(player2, 100)
            expect(board.check_box[99]).to eql(nil)
        end
    end



end
