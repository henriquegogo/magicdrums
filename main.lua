function love.load()
  count = 0
  timer = 0
  steps = 8
  bpm = 100
  ratio = 0.1 / 3 * bpm

  kick  = love.audio.newSource('samples/kick.wav',  'static')
  snare = love.audio.newSource('samples/snare.wav', 'static')
  hihat = love.audio.newSource('samples/hihat.wav', 'static')
  empty = love.audio.newSource('samples/empty.wav', 'static')

  seq = {kick, hihat, snare, hihat, kick, hihat, snare, kick, kick}
end

function love.keypressed(key)
  local sample

  if key == 'kp1' then
    sample = kick:clone()
  elseif key == 'kp2' then
    sample = snare:clone()
  elseif key == 'kp3' then
    sample = hihat:clone()
  else
    sample = empty:clone()
  end

  seq[(count % steps) + 1] = sample
  sample:play()
end

function love.update(dt)
  local oldcount = math.floor(timer * ratio)
  timer = timer + dt
  count = math.floor(timer * ratio)

  if count ~= oldcount then
    print('Metronome: ' .. (count % steps) + 1)

    local sample = seq[(count % steps) + 1]:clone()
    sample:play()
  end
end
