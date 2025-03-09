{self, ...}: {
  age.secrets = {
    achacegaGmail.file = "${self.inputs.secrets}/aly/mail/gmail.age";
    alyraffaufFastmail.file = "${self.inputs.secrets}/aly/mail/fastmail.age";
    rclone-b2.file = "${self.inputs.secrets}/rclone/b2.age";
  };
}
