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


end
