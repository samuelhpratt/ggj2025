tracks = {}

function updateTracks()
    for track in all(tracks) do
        track:update()
    end
end

function createTrack(n,ch,dur)
    local track = {n=n, ch=ch, dur=dur}
    track.playing = false
    track.timeLeft = nil

    track.update = function(self)
        --update function for each track
        --log(self.playing)
        if self.playing then
            self.timeLeft -= 1
        else
            --do nothing
        end
    end

    track.requestPlay = function(self)
        if self.playing then
            if self.timeLeft > 0 then
                --do nothing
            elseif self.timeLeft <=0 then
                self.timeLeft = self.dur
                self:play()
            end
        else
            self.timeLeft = self.dur
            self.playing = true
            self:play()
        end
    end

    track.play = function(self)
        --log("play")
        sfx(self.n, self.ch)
    end

    add(tracks, track)
    return track
end

--helpers

--stops all looping on the specified channel
function stopAllLooping(ch)
    sfx(-2, ch)
end
