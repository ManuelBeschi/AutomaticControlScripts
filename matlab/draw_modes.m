clear all;
close all;
clc

while true
    multeplicita=input('Set multeplicity:\n');
    if isscalar(multeplicita)==0
        fprintf('Multeplicity should be a positive integer\n');
        continue;
    end
    if (floor(multeplicita)~=multeplicita)
        fprintf('Multeplicity should be a positive integer\n');
        continue;
    end
    if (multeplicita<1)
        fprintf('Multeplicity should be a positive integer\n');
        continue;
    end
    break
end

polo=-1+1i;

tempo=5;
t=linspace(0,tempo,1e3)';
limite=10;

subplot(1,2,1)
% draw a box
plot([-limite -limite limite limite -limite], ...
    [-limite limite limite -limite -limite], ...
    'k','LineWidth',3)

hold on

% x axis
plot([-limite,limite],[0 0],'k','LineWidth',2);

% y axis
plot([0,0],[-limite,limite],'k','LineWidth',2);

axis equal
axis square
axis manual

p1=plot(real(polo), imag(polo), 'x','MarkerSize', 20);
p2=plot(real(polo),-imag(polo), 'x','MarkerSize', 20);


grid on
xlabel('Real')
ylabel('Imag')
title(sprintf('Complex plan: poles. Multeplicity: %d',multeplicita))

subplot(1,2,2)
m1=t.^(multeplicita-1).*real(exp(polo*t));
m2=t.^(multeplicita-1).*imag(exp((polo)*t));
inviluppo=t.^(multeplicita-1).*exp(real(polo)*t);

hm1=plot(t,m1,'Color',p1.Color,'LineWidth',2);
hold on
hm2=plot(t,m2,'Color',p2.Color,'LineWidth',2);
hm3=plot(t,inviluppo,'--k','LineWidth',2);
hm4=plot(t,-inviluppo,'--k','LineWidth',2);
xlabel('time')
ylabel('amplitude')
title('Mode')
grid on
xlim([0 tempo])

hfig=gcf;
while ishandle(hfig)
    [x_coord, y_coord]=ginput(1);
    if abs(y_coord)<0.1
        y_coord=0;
    end
    if abs(x_coord)<0.1
        x_coord=0;
    end
    polo=x_coord+1i*y_coord;
    m1=t.^(multeplicita-1).*real(exp(polo*t));
    if y_coord==0
        m2=nan(length(t),1);
        inviluppo=nan(length(t),1);
    else
        m2=t.^(multeplicita-1).*imag(exp((polo)*t));
        inviluppo=t.^(multeplicita-1).*exp(real(polo)*t);

    end
    p1.XData=real(polo);
    p1.YData=imag(polo);
    p2.XData=real(polo);
    p2.YData=-imag(polo);

    hm1.YData=m1;
    hm2.YData=m2;
    hm3.YData=inviluppo;
    hm4.YData=-inviluppo;
    drawnow
end