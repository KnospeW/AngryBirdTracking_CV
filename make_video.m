%make_video('./test/yellow_birds_result','jpg','yellow.avi',3)
function make_video(video_dirs,extension,aviname,fps)
      resnames=dir(fullfile(video_dirs,['*.' extension]));
      aviobj=VideoWriter(aviname);
      aviobj.FrameRate=fps;
      open(aviobj);
      for i=1:length(resnames)
          img=imread(fullfile(video_dirs,resnames(i).name));
          F=im2frame(img);
          if sum(F.cdata(:))==0
              error('black');
          end
          writeVideo(aviobj,F);
      end
      close(aviobj);
end