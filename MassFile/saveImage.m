function saveImage(count, txt)
    saveas(gcf,strcat('images\',num2str(count)));
    fid=fopen('directory.txt','a');
    fprintf(fid,'%s %s\n',txt,strcat('images\',num2str(count),'.fig'));
    fclose(fid);
end