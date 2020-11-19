require './lib/board'
require './lib/player'

describe Board do

    let(:player1) { Player.new('p1', 'X') }
    let(:player2) { Player.new('p2', 'O') }
    let(:board) { Board.new(player1, player2) }
    let(:check_box) { [] }
    let(:board_full) { ['X','O','X','O','X','O','O','X','O']}
    let(:board_not_full) { ['X','O','_','O','X','_','O','X','_']}
    let(:player1_win) { ['X','X','X','O','O','_','_','_','_'] }
    let(:player2_win) { ['X','X','_','O','O','O','_','_','_'] }

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
        before {
            board.empty
            @player_choice = board.update_display_board(player=player1, choice)
        }

        context 'when player choice is between range 1-9' do
            let(:choice) { 3 }
            let(:player) { player1 }

            it 'returns player symbol' do
                expect(board.check_box[choice - 1]).to eql(player.symbol)
            end
        end

        context 'when player choice is not between range 1-9' do
            let(:choice) { 100 }

            it 'returns nil' do
                expect(board.check_box[choice - 1]).to eql(nil)
            end
        end

        context 'when player choice is string' do
            let(:choice) { 'a' }

            it 'returns false' do
                expect(@player_choice).to eql(false)
            end
        end

        context 'when player choice is float' do
            let(:choice) { 2.4 }
            let(:player) { player1 }

            it 'returns player symbol and update check_box' do
                expect(@player_choice).to eql(player.symbol)
            end
        end
    end

    describe '#winner?' do
        before { board.empty }
        context 'when player1 is winner' do
            it 'return true' do
                board.check_box = player1_win

                expect(board.winner?).to eql(true)
            end
        end

        context 'when player2 is winner' do
            it 'return true' do
                board.check_box = player2_win

                expect(board.winner?).to eql(true)
            end
        end

        context 'when draw' do
            it 'return false' do
                board.check_box = board_full

                expect(board.winner?).to eql(false)
            end
        end

        context 'when next move is winning' do
            it 'return true' do
                board.check_box = board_not_full
                board.check_box[8] = 'X'

                expect(board.winner?).to eql(true)
            end
        end
    end

end
