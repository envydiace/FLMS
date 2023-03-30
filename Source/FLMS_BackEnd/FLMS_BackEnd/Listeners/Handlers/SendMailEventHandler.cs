namespace FLMS_BackEnd.Listeners.Events
{
    public class SendMailEventHandler
    {
        public event EventHandler<SendMailEventArgs> SendMailEventArgs;

        public virtual void OnSendMailReached(SendMailEventArgs e)
        {
            SendMailEventArgs?.Invoke(this, e);
        }
    }
}
