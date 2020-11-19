require './lib/board'
require './lib/player'

describe Board do
    
    let(:player1) { Player.new('p1', 'X') }
    let(:player2) { Player.new('p2', 'O') }
    let(:board) { Board.new(player1, player2) }
    let(:check_box) { [] }

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



end
