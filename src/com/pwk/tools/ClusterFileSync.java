package com.pwk.tools;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;

/**
 * Created by Administrator on 2015/8/2.
 */
public class ClusterFileSync implements Runnable {
    private static String ip = "183.81.167.241";
    private static String remoteUser = "root";
    private static String remotePwd = "YmY0MmJlZWEyNWZmM2I3ZjkxMjdmNmZm";
    private String absFileName;

    private JSch jSch;
    private Session session;
    private Channel channel;
    private ChannelSftp sftp;

    public ClusterFileSync(String absFileName) {
        this.absFileName = absFileName;
    }

    @Override
    public void run() {
        sync();
    }

    public void sync(){
        jSch = new JSch();
        try {
            session = jSch.getSession(remoteUser,ip,22);
            session.setPassword(remotePwd);
            session.connect();

            channel = session.openChannel("sftp");
            channel.connect();
            sftp = (ChannelSftp)channel;

            //start synchronization to remote sever
            sftp.put(absFileName,absFileName);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
