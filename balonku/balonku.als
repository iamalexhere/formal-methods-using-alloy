module balonku

-- Define colors for the balloons
abstract sig Color {}
one sig Green, Yellow, Grey, Pink, Blue extends Color {}

-- Define balloon states
abstract sig BalloonState {}
one sig Intact, Popped extends BalloonState {}

-- Define emotional states
abstract sig EmotionalState {}
one sig Happy, Upset extends EmotionalState {}

-- Define a balloon
sig Balloon {
  color: one Color
}

-- Define the world state
sig State {
  balloons: set Balloon,
  balloonState: Balloon -> one BalloonState,
  emotion: one EmotionalState,
  holding: set Balloon
}

-- Define the initial state
pred init[s: State] {
  -- There are exactly 5 balloons with different colors
  #s.balloons = 5
  all b: s.balloons | s.balloonState[b] = Intact
  one b: s.balloons | b.color = Green
  one b: s.balloons | b.color = Yellow
  one b: s.balloons | b.color = Grey
  one b: s.balloons | b.color = Pink
  one b: s.balloons | b.color = Blue
  
  -- Initially happy
  s.emotion = Happy
  
  -- Not holding any balloons yet
  s.holding = none
}

-- Define the action of a balloon popping
pred pop[s: State, s_next: State, b: Balloon] {
  -- Precondition: balloon must be intact
  b in s.balloons
  s.balloonState[b] = Intact
  
  -- The set of balloons remains the same
  s_next.balloons = s.balloons
  
  -- Update the state of the popped balloon
  s_next.balloonState = s.balloonState ++ (b -> Popped)
  
  -- If green balloon pops, become upset
  (b.color = Green => s_next.emotion = Upset else s_next.emotion = s.emotion)
  
  -- Holding remains the same
  s_next.holding = s.holding
}

-- Define the action of holding balloons tightly
pred holdTightly[s: State, s_next: State] {
  -- Can only hold intact balloons
  s_next.holding = {b: s.balloons | s.balloonState[b] = Intact}
  
  -- Balloons and their states remain unchanged
  s_next.balloons = s.balloons
  s_next.balloonState = s.balloonState
  
  -- Emotional state remains the same
  s_next.emotion = s.emotion
}

-- Define a trace of the song
pred songTrace {
  some s0, s1, s2: State | {
    init[s0] and
    some b: s0.balloons | b.color = Green and pop[s0, s1, b] and
    holdTightly[s1, s2]
  }
}

-- Run the model
run songTrace for 5 Balloon, 3 State