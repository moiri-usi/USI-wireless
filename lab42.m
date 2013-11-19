taps = 20;
T = 1;
roll_off = 0.22;
L = 4;
%Nc = 100; % use if epsilon changes in time
Nc = inf; % use if epsilon is constant

sig = load('r_sequence_4_8dB.mat');

sig_up_rcv = rrcf(sig.r, taps, T, roll_off, L);
epsilon = t_estimator(sig_up_rcv, Nc);

% prepend the transmitted signal with a random sequence of values of defined
% length. At the receiver, this sequence is then cut off after the frame
% synchronizer.

clf;
plot(epsilon);
ylabel('epsilon');
xlabel('n');
