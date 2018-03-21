function love.load()
  count = 0
  timer = 0
  steps = 16
  bpm = 100
  ratio = 0.1 / 1.5 * bpm

  kick  = love.audio.newSource('samples/kick.wav',  'static')
  snare = love.audio.newSource('samples/snare.wav', 'static')
  hihat = love.audio.newSource('samples/hihat.wav', 'static')
  empty = love.audio.newSource('samples/empty.wav', 'static')

  seq = {kick, empty, hihat, empty, snare, empty, hihat, empty, kick, empty, hihat, empty, snare, empty, kick, empty, kick}
end

function love.keypressed(key)
  local sample

  if key == 'kp1' then
    sample = kick
  elseif key == 'kp2' then
    sample = snare
  elseif key == 'kp3' then
    sample = hihat
  else
    sample = empty
  end

  seq[(count % steps) + 1] = sample
  sample:clone():play()
end

function love.update(dt)
  local oldcount = math.floor(timer * ratio)
  timer = timer + dt
  count = math.floor(timer * ratio)

  if count ~= oldcount then
    print('Metronome: ' .. (count % steps) + 1)

    local sample = seq[(count % steps) + 1]
    sample:clone():play()
  end
end
