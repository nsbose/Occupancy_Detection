function [data] = call_thingspeak( channel_ID, api_key )
%CALL_THINGSPEAK Summary of this function goes here
%   Connects the current iteration to the thingspeak IoT server
%   Begins downloading data


% readChannelID = channel_ID;
% readAPIKey = api_key;

readChannelID = 170203;
readAPIKey = 'N1KH6CG15F4ZDMU6';
data = thingSpeakRead(readChannelID, 'ReadKey', readAPIKey);
assignin('base', 'thingspeakdata', data);
end

