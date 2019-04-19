<GameFile>
  <PropertyGroup Name="UISelectRole" Type="Scene" ID="a2ee0952-26b5-49ae-8bf9-4f1d6279b798" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene" ctype="GameNodeObjectData">
        <Size X="960.0000" Y="640.0000" />
        <Children>
          <AbstractNodeData Name="Input_Img" ActionTag="-929226463" Tag="9" IconVisible="False" LeftMargin="374.5135" RightMargin="355.4865" TopMargin="518.6568" BottomMargin="71.3432" LeftEage="75" RightEage="75" TopEage="16" BottomEage="16" Scale9OriginX="75" Scale9OriginY="16" Scale9Width="80" Scale9Height="18" ctype="ImageViewObjectData">
            <Size X="230.0000" Y="50.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="489.5135" Y="96.3432" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5099" Y="0.1505" />
            <PreSize X="0.2396" Y="0.0781" />
            <FileData Type="Normal" Path="art/res/input_bg.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="TextField_Name" ActionTag="-792278231" Tag="8" IconVisible="False" LeftMargin="389.2219" RightMargin="430.7781" TopMargin="529.8611" BottomMargin="82.1389" TouchEnable="True" FontSize="28" IsCustomSize="True" LabelText="" PlaceHolderText="请输入昵称" MaxLengthEnable="True" MaxLengthText="10" ctype="TextFieldObjectData">
            <Size X="140.0000" Y="28.0000" />
            <AnchorPoint ScaleY="0.5000" />
            <Position X="389.2219" Y="96.1389" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="165" B="0" />
            <PrePosition X="0.4054" Y="0.1502" />
            <PreSize X="0.1458" Y="0.0437" />
          </AbstractNodeData>
          <AbstractNodeData Name="Text_Notice" ActionTag="62506081" Tag="10" IconVisible="False" LeftMargin="395.6725" RightMargin="394.3275" TopMargin="577.0112" BottomMargin="42.9888" FontSize="20" LabelText="昵称请至少4个字符" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
            <Size X="170.0000" Y="20.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="480.6725" Y="52.9888" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5007" Y="0.0828" />
            <PreSize X="0.1771" Y="0.0313" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="110" G="110" B="110" />
          </AbstractNodeData>
          <AbstractNodeData Name="Panel_1" ActionTag="459773588" Tag="12" IconVisible="False" LeftMargin="126.4505" RightMargin="633.5495" TopMargin="169.3451" BottomMargin="270.6549" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="200.0000" Y="200.0000" />
            <Children>
              <AbstractNodeData Name="Image_person" ActionTag="-149546173" Tag="13" IconVisible="False" LeftMargin="57.4550" RightMargin="57.5450" TopMargin="40.7446" BottomMargin="38.2554" LeftEage="28" RightEage="28" TopEage="39" BottomEage="39" Scale9OriginX="28" Scale9OriginY="39" Scale9Width="29" Scale9Height="43" ctype="ImageViewObjectData">
                <Size X="85.0000" Y="121.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="99.9550" Y="98.7554" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4998" Y="0.4938" />
                <PreSize X="0.4250" Y="0.6050" />
                <FileData Type="Normal" Path="art/res/person1.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Image_select" ActionTag="407712016" Tag="14" IconVisible="False" LeftMargin="54.9563" RightMargin="55.0437" TopMargin="20.4294" BottomMargin="19.5706" LeftEage="72" RightEage="43" TopEage="62" BottomEage="60" Scale9OriginX="72" Scale9OriginY="62" Scale9Width="173" Scale9Height="86" ctype="ImageViewObjectData">
                <Size X="90.0000" Y="160.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="99.9563" Y="99.5706" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4998" Y="0.4979" />
                <PreSize X="0.4500" Y="0.8000" />
                <FileData Type="Normal" Path="art/res/person_select.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position X="126.4505" Y="270.6549" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.1317" Y="0.4229" />
            <PreSize X="0.2083" Y="0.3125" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Panel_2" ActionTag="-296813886" Tag="15" IconVisible="False" LeftMargin="383.3303" RightMargin="376.6697" TopMargin="167.3022" BottomMargin="272.6978" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="200.0000" Y="200.0000" />
            <Children>
              <AbstractNodeData Name="Image_person" ActionTag="198492859" Tag="16" IconVisible="False" LeftMargin="57.4550" RightMargin="57.5450" TopMargin="40.7446" BottomMargin="38.2554" LeftEage="28" RightEage="28" TopEage="39" BottomEage="39" Scale9OriginX="28" Scale9OriginY="39" Scale9Width="29" Scale9Height="43" ctype="ImageViewObjectData">
                <Size X="85.0000" Y="121.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="99.9550" Y="98.7554" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4998" Y="0.4938" />
                <PreSize X="0.4250" Y="0.6050" />
                <FileData Type="Normal" Path="art/res/person1.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Image_select" ActionTag="-1973813454" Tag="17" IconVisible="False" LeftMargin="54.9563" RightMargin="55.0437" TopMargin="20.4294" BottomMargin="19.5706" LeftEage="72" RightEage="43" TopEage="62" BottomEage="60" Scale9OriginX="72" Scale9OriginY="62" Scale9Width="173" Scale9Height="86" ctype="ImageViewObjectData">
                <Size X="90.0000" Y="160.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="99.9563" Y="99.5706" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4998" Y="0.4979" />
                <PreSize X="0.4500" Y="0.8000" />
                <FileData Type="Normal" Path="art/res/person_select.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position X="383.3303" Y="272.6978" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.3993" Y="0.4261" />
            <PreSize X="0.2083" Y="0.3125" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Panel_3" ActionTag="-61264181" Tag="18" IconVisible="False" LeftMargin="640.2095" RightMargin="119.7905" TopMargin="170.0765" BottomMargin="269.9235" TouchEnable="True" ClipAble="False" BackColorAlpha="102" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="200.0000" Y="200.0000" />
            <Children>
              <AbstractNodeData Name="Image_person" ActionTag="467725142" Tag="19" IconVisible="False" LeftMargin="57.4550" RightMargin="57.5450" TopMargin="40.7446" BottomMargin="38.2554" LeftEage="28" RightEage="28" TopEage="39" BottomEage="39" Scale9OriginX="28" Scale9OriginY="39" Scale9Width="29" Scale9Height="43" ctype="ImageViewObjectData">
                <Size X="85.0000" Y="121.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="99.9550" Y="98.7554" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4998" Y="0.4938" />
                <PreSize X="0.4250" Y="0.6050" />
                <FileData Type="Normal" Path="art/res/person1.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="Image_select" ActionTag="805519540" Tag="20" IconVisible="False" LeftMargin="54.9563" RightMargin="55.0437" TopMargin="20.4294" BottomMargin="19.5706" LeftEage="72" RightEage="43" TopEage="62" BottomEage="60" Scale9OriginX="72" Scale9OriginY="62" Scale9Width="173" Scale9Height="86" ctype="ImageViewObjectData">
                <Size X="90.0000" Y="160.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="99.9563" Y="99.5706" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4998" Y="0.4979" />
                <PreSize X="0.4500" Y="0.8000" />
                <FileData Type="Normal" Path="art/res/person_select.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position X="640.2095" Y="269.9235" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.6669" Y="0.4218" />
            <PreSize X="0.2083" Y="0.3125" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Button_Sure" ActionTag="-4054656" Tag="21" IconVisible="False" LeftMargin="622.3859" RightMargin="291.6141" TopMargin="523.0868" BottomMargin="80.9132" TouchEnable="True" FontSize="20" ButtonText="确认" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="16" Scale9Height="14" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
            <Size X="46.0000" Y="36.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="645.3859" Y="98.9132" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.6723" Y="0.1546" />
            <PreSize X="0.0479" Y="0.0562" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
            <NormalFileData Type="Default" Path="Default/Button_Normal.png" Plist="" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="110" G="110" B="110" />
          </AbstractNodeData>
          <AbstractNodeData Name="Button_Back" ActionTag="-1576229606" Tag="20" IconVisible="False" LeftMargin="32.3859" RightMargin="881.6141" TopMargin="585.0868" BottomMargin="18.9132" TouchEnable="True" FontSize="20" ButtonText="返回" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="16" Scale9Height="14" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
            <Size X="46.0000" Y="36.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="55.3859" Y="36.9132" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.0577" Y="0.0577" />
            <PreSize X="0.0479" Y="0.0562" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
            <NormalFileData Type="Default" Path="Default/Button_Normal.png" Plist="" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="110" G="110" B="110" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>