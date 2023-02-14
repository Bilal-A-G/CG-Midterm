Shader "Custom/Forcefield"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RimPower("Rim Power", float) = 1
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }

        CGPROGRAM
        #pragma surface surf Standard noshadow alpha:blend
        
        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
            float3 worldNormal;
        };

        half _Glossiness;
        half _Metallic;
        half _RimPower;
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;

            const float rim = 1 - dot(IN.worldNormal, IN.viewDir);
            const float rimAmount = pow(rim, _RimPower);

            o.Emission = rimAmount * c.rgb;
            o.Alpha = rimAmount;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
