% Produce a demonstration figure for a 2D spectrum

% An image with vertical stripes
xy = [0:7;0:7;0:7;0:7;0:7;0:7;0:7;0:7];
pxy = sin(xy*pi/4);
subplot(2,2,1), imagesc(pxy),colormap(gray);
axis xy;
yt=get(gca, 'YTick');
set(gca, 'YTickLabel', yt-1);
xt=get(gca, 'XTick');
set(gca, 'XTickLabel', xt-1);
xlabel('x'),ylabel('y');
title('p_{xy}')

ykl = abs(fft2(pxy));
subplot(2,2,2), imagesc(ykl),colormap(gray);
axis xy;
yt=get(gca, 'YTick');
set(gca, 'YTickLabel', yt-1);
xt=get(gca, 'XTick');
set(gca, 'XTickLabel', xt-1);
xlabel('k'),ylabel('l');
title('y_{kl}')

% An image with diagonal stripes
for x = [0:7],
  for y = [0:7],
    xy(x+1,y+1) = x+y;
  end;
end;
pxy = sin(xy*pi/4);
subplot(2,2,3), imagesc(pxy),colormap(gray);
axis xy;
yt=get(gca, 'YTick');
set(gca, 'YTickLabel', yt-1);
xt=get(gca, 'XTick');
set(gca, 'XTickLabel', xt-1);
xlabel('x'),ylabel('y');
title('p_{xy}')

ykl = abs(fft2(pxy));
subplot(2,2,4), imagesc(ykl),colormap(gray);
axis xy;
yt=get(gca, 'YTick');
set(gca, 'YTickLabel', yt-1);
xt=get(gca, 'XTick');
set(gca, 'XTickLabel', xt-1);
xlabel('k'),ylabel('l');
title('y_{kl}')

print -depsc2 'dctdemo.eps'
