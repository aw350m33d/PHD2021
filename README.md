# PHD 2021 Threat hunting with Jupyter and Sigma notes

Materials for speaking at Positive Hack Days 2021


## My GitHub repos:

- This notes: https://github.com/aw350m33d/PHD2021
- fork of MSTICPy: https://github.com/aw350m33d/msticpy
- ptnad_api: https://github.com/aw350m33d/ptnad_api
- mpsiem_api: https://github.com/aw350m33d/mpsiem_api
- fork of Sigma: https://github.com/aw350m33d/sigma

Install via PIP from GitHub:
```bash
  pip3 install -e 'git+https://github.com/aw350m33d/msticpy.git@mpsiem_data_provider#egg=msticpy[all]'
```

## Hands-on lab:

### Pull&Run Docker container from DockerHub
```bash
  docker pull aw350m3/threat_research
  docker run -it --name pt_hunter \
    -p 127.0.0.1:8080:8080 -p 8888:8888 \
    -v "$HOME/.config:/home/coder/.config" \
    -v "$PWD:/home/coder/project" \
    -u "$(id -u):$(id -g)" \
    -e "DOCKER_USER=$USER" \
    -e PASSWORD=PHD2021 \
    aw350m3/threat_research
```

### Build a container yourself if you can't download it from DockerHub

Download `Dockerfile`:
> https://raw.githubusercontent.com/aw350m33d/PHD2021/main/Dockerfile

```bash
docker build -t phd_threat_research .
```

### Sigma rule template
```yaml
  title: <TITLE>
  id: <UUID>
  description: <DESCRIPTION> 
  status: experimental
  date: 2021/05/21
  author: <AUTHOR>
  tags:
      - defense.evasion
      - attack.T1055.012
  references:
      - <REFERENCE>
  logsource:
      product: windows
      service: sysmon
  detection:
      <NAME>:
          EventID:
              - <ID>
      condition: <CONDITION>
  falsepositives:
      - <FPs>
  level: <low, medium, high>
```

### References
Process Tampering:
    - https://jxy-s.github.io/herpaderping/
    - https://medium.com/falconforce/sysmon-13-process-tampering-detection-820366138a6c
    - https://pentestlaboratories.com/2021/01/18/process-herpaderping-windows-defender-evasion/

Susp UA:
    - https://gist.github.com/GossiTheDog/77527a34cdecb0ad840910c0beb8ba41
    - https://lolbas-project.github.io/lolbas/Binaries/Certreq/
    - https://lolbas-project.github.io/lolbas/Binaries/Certutil/
    - https://lolbas-project.github.io/lolbas/Binaries/Regsvr32/
    - https://lolbas-project.github.io/lolbas/Binaries/Msiexec/